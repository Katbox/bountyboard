class BountiesController < ApplicationController

  include SessionsHelper
  require 'sanitize'

  respond_to :json, :html

  def self.BOUNTIES_PER_PAGE
    20
  end

  # Display a list of all bounties in the system, with links to see their
  # individual bounties.
  def index
    @bounties = Bounty
      .viewable_by(currentUser)
      .page(params[:page]).per(BountiesController.BOUNTIES_PER_PAGE)

    # apply filters from the user

    # default filter values
    filters =  {
      :price_min => nil,
      :price_max => nil,
      :adult => "kid-friendly",
      :own => nil,
      :may_accept => nil,
      :status => nil,
    }.with_indifferent_access

    filters.merge!(params)

    if filters[:price_min]
      @bounties = @bounties.price_greater_than params["price_min"].to_f
    end
    if filters[:price_max]
      @bounties = @bounties.price_less_than params["price_max"].to_f
    end
    if filters[:adult] == "adult"
      @bounties = @bounties.only_adult_content
    elsif filters[:adult] == "kid-friendly"
      @bounties = @bounties.no_adult_content
    end
    if filters[:own] && currentUser
      @bounties = @bounties.owned_by currentUser
    end
    if filters[:may_accept] && currentUser.is_a?(Artist)
      @bounties = @bounties.may_accept currentUser
    end
    if filters[:status]
      @bounties = @bounties.only_status(filters[:status])
    end

    respond_with @bounties.all.sort { |bounty| -bounty.score }
  end

  # Display an individual bounty.
  def show
    @bounty = Bounty.find(params[:id])
    if !@bounty.viewable_by?(currentUser)
      flash[:error] = "That bounty is private."
      redirect_to root_path
    end
  end

  # Display the form to create a new bounty. Anyone may perform this action.
  def new
    unless signed_in?
      flash[:error] = "You must sign in."
      redirect_to root_path
    end
    @bounty = Bounty.new
  end

  # Create a new bounty. Anyone may perform this action.
  def create
    unless signed_in?
      flash[:error] = "You must sign in."
      redirect_to root_path
    end

    # If no specific artists were selected. Then create a candidacy to all
    # active artists.
    if !params[:bounty][:artist_ids] || params[:bounty][:artist_ids] == [""]
	  params[:bounty][:artist_ids] = Artist.where(:active => true).pluck(:id)
    end

    # Sanitize the name and description fields for bounties. Clean name of all
    # HTML, clean descs using "Relaxed" method which allows:
    #
    # "Allows an even wider variety of markup than BASIC, including images and
    # tables. Links are still limited to FTP, HTTP, HTTPS, and mailto protocols,
    # while images are limited to HTTP and HTTPS. In this mode, rel="nofollow"
    # is not added to links."

    params[:bounty][:name] = Sanitize.clean(params[:bounty][:name])
    params[:bounty][:name] = Sanitize.clean(params[:bounty][:tag_line])
    params[:bounty][:desc] = Sanitize.clean(params[:bounty][:desc], Sanitize::Config::RELAXED)

    @bounty = Bounty.new(bounty_create_params)
    @bounty.owner = currentUser

    if @bounty.save
      flash[:notice] = "Bounty created successfully!"
      redirect_to root_path
    else
      flash[:error] = "Error saving bounty."
      render 'new'
    end
  end

  # Display the edit form for the bounty. Artists that are candidates for the
  # bounty may use this for completion of a bounty. Owners of the bounty
  # may edit all other properties.
  def edit
    unless signed_in?
      flash[:error] = "You must sign in."
      redirect_to root_path
    end
    @bounty = Bounty.find(params[:id])
    # The format parameter is a string passed along with the id when using
    # bounty_path. Ex. bounty_path(4, "Complete") would set @format to
    # "Complete", which the view will use to render the form for Completing a
    # bounty, maintaining REST.
    @format = params[:format]
    unless (@bounty.owner == currentUser || @bounty.artists.include?(currentUser))
      flash[:error] = "You are not authorized to edit this bounty."
      redirect_to root_path
    end
  end

  # Update the bounty. Artists that are candidates for the bounty may use this
  # for completion of a bounty. Owners of the bounty may edit all other
  # properties.
  def update
    unless signed_in?
      flash[:error] = "You must sign in."
      redirect_to root_path
    end
    @bounty = Bounty.find(params[:id])
    unless (@bounty.owner == currentUser || @bounty.artists.include?(currentUser))
      flash[:error] = "You are not authorized to edit this bounty."
      redirect_to root_path
    end
    if params[:bounty][:url]
      @bounty.artwork_from_url(params[:bounty][:url])
      if @bounty.update_attributes(bounty_update_params)
        flash[:notice] = "Bounty Completed!"
        redirect_to root_path
      else
        flash[:error] = "Error completing bounty."
        redirect_to root_path
      end
    else
      # Sanitize the name and description fields for bounties. Clean name of all
      # HTML, clean descs using "Relaxed" method which allows:
      #
      # "Allows an even wider variety of markup than BASIC, including images and
      # tables. Links are still limited to FTP, HTTP, HTTPS, and mailto protocols,
      # while images are limited to HTTP and HTTPS. In this mode, rel="nofollow"
      # is not added to links."
      params[:bounty][:name] = Sanitize.clean(params[:bounty][:name])
      params[:bounty][:name] = Sanitize.clean(params[:bounty][:tag_line])
      params[:bounty][:desc] = Sanitize.clean(params[:bounty][:desc], Sanitize::Config::RELAXED)

      if @bounty.update_attributes(bounty_update_params)
        flash[:notice] = "Bounty Updated!"
        redirect_to root_path
      else
        flash[:error] = "Error updating bounty."
        redirect_to root_path
      end
    end
  end

  # Delete the bounty. Admins may delete any bounty. But the bounty's owner may
  # only do this if the bounty is unclaimed.
  def destroy
    unless signed_in?
      flash[:error] = "You must sign in."
      redirect_to root_path
    end
    @bounty = Bounty.find(params[:id])

    if (@bounty.owner == currentUser && (@bounty.status == 'Unclaimed')) || currentUser.admin?
      if Bounty.destroy(params[:id])
        flash[:notice] = "Bounty successfully removed!"
        redirect_to root_path
      else
        flash[:error] = "Error removing bounty."
        redirect_to root_path
      end
    else
      if @bounty.owner != currentUser
        flash[:error] = "You are not authorized to remove this bounty."
        redirect_to root_path
      elsif @bounty.status == "Accepted"
        acceptor = @bounty.acceptor_candidacy.artist.get_identifier
        flash[:error] = "This bounty is being worked on by #{acceptor} and cannot be deleted."
        redirect_to root_path
      else
        flash[:error] = "This bounty is #{@bounty.status} and cannot be deleted."
        redirect_to root_path
      end
    end
  end

  private

    def bounty_create_params
      params.require(:bounty).permit(
        :name,
        :desc,
        :price_cents,
        :price_currency,
        :adult_only,
        :private,
        :complete_by,
        :tag_line
      )
    end

    def bounty_update_params(bounty)
      permitted_keys = [
        :name,
        :desc,
        :price_cents,
        :price_currency,
        :adult_only,
        :private,
        :complete_by,
        :tag_line
      ]
      # the acccepting artist can complete a bounty
      if bounty.accepting_candidacy && bounty.accepting_candidacy.artist == currentUser
        permitted_keys.concat([
          :url,
          :preview,
          :completed_at
        ])
      end
      params.require(:bounty).permit(permitted_keys)
    end

end

