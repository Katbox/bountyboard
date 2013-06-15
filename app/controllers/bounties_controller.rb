class BountiesController < ApplicationController

  include SessionsHelper

  # Display a list of all bounties in the system, with links to see their
  # individual bounties.
  def index
    @bounty = Bounty.all
    @bounty.sort_by{|e| e[:created_at]}
  end

  # Display an individual bounty.
  def show
    @bounty = Bounty.find(params[:id])
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
    if params[:bounty][:artist_ids]==[""]
      id_array = []
      @artist = Artist.all
      @artist.each do |a|
        if a.active
          id_array.append(a.id.to_s)
        end
      end
      params[:bounty][:artist_ids] = id_array
    end

    @bounty = Bounty.new(params[:bounty])
    @bounty.owner = currentUser

    if @bounty.save
      flash[:notice] = "Bounty created successfully."
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
    unless (@bounty.owner == currentUser || @bounty.has_candidate?(currentUser.name))
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
    unless (@bounty.owner == currentUser || @bounty.has_candidate?(currentUser.name))
      flash[:error] = "You are not authorized to edit this bounty."
      redirect_to root_path
    end
    if params[:bounty][:url] != nil
      params[:bounty][:completed_at] = Time.now
    end
    if @bounty.update_attributes(params[:bounty])
      flash[:notice] = "Bounty Updated!"
      redirect_to root_path
    else
      flash[:error] = "Error updating bounty."
      redirect_to root_path
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
        flash[:notice] = "Bounty successfully removed."
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
        acceptor = @bounty.accepting_artist.get_identifier
        flash[:error] = "This bounty is being worked on by #{acceptor} and cannot be deleted."
        redirect_to root_path
      else
        flash[:error] = "This bounty is #{@bounty.status} and cannot be deleted."
        redirect_to root_path
      end
    end
  end
end

