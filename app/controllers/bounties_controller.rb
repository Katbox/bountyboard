class BountiesController < ApplicationController

  include SessionsHelper

  # Display a list of all bounties in the system, with links to see their
  # individual bounties.
  def index
    @bounty = Bounty.all
    @artist = Artist.all
    @bounty.sort_by{|e| e[:created_at]}
  end

  # Display an individual bounty.
  def show
    @bounty = Bounty.find(params[:id])
  end

  # Display the form to create a new bounty. Anyone may perform this action.
  def new
    unless signed_in?
      redirect_to root_path, :error => "You must sign in."
    end
    @bounty = Bounty.new
  end

  # Create a new bounty. Anyone may perform this action.
  def create
    unless signed_in?
      redirect_to root_path, :error => "You must sign in to create a bounty."
      return
    end

    # If no specific artists were selected. Then create a candidacy to all
    # artists.
    if params[:bounty][:artist_ids]==[""]
      id_array = []
      @artist = Artist.all
      @artist.each do |a|
        id_array.append(a.id.to_s)
      end
      params[:bounty][:artist_ids] = id_array
    end

    @bounty = Bounty.new(params[:bounty])
    @bounty.owner = currentUser

    if @bounty.save
      redirect_to root_path, :notice => "Bounty created successfully."
    else
      flash[:error] = "Error saving bounty."
      render 'new'
    end
  end

  # Display the edit form for the bounty. Artists that are candidates for the
  # bounty may use this for completion of a bounty. Owners of the bounty
  # may edit all other properties.
  def edit
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
    @bounty = Bounty.find(params[:id])
    unless (@bounty.owner == currentUser || @bounty.has_candidate?(currentUser.name))
      redirect_to root_path, :error => "You are not authorized to edit this bounty."
    end
    if @bounty.update_attributes(params[:bounty])
      redirect_to root_path, :notice => "Bounty Updated!"
    else
      redirect_to root_path, :error => "Error updating bounty."
    end
  end

  # Delete the bounty. Admins may delete any bounty. But the bounty's owner may
  # only do this if the bounty is unclaimed.
  def destroy
    @bounty = Bounty.find(params[:id])

    if (@bounty.owner == currentUser && (@bounty.status == 'Unclaimed')) || currentUser.admin?
      if Bounty.destroy(params[:id])
        flash[:notice] = "Bounty successfully removed."
      else
        flash[:error] = "Error removing bounty."
      end
    else
      if @bounty.owner != currentUser
        flash[:error] = "You are not authorized to remove this bounty."
      elsif @bounty.status == "Accepted"
        acceptor = @bounty.accepting_artist.get_identifier
        flash[:error] =<<message
"This bounty is being worked on by #{acceptor} and cannot be deleted. You will
need to contact #{acceptor} and ask that he or she release their claim to the
bounty."
message
      else
        flash[:error] = "This bounty is #{@bounty.status} and cannot be deleted."
      end
    end
    redirect_to root_path
  end
end

