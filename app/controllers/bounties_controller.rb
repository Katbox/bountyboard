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
      redirect_to root_path, :error => "You must sign in."
    end
    @bounty = Bounty.new
  end

  # Create a new bounty. Anyone may perform this action.
  def create
    unless signed_in?
      redirect_to root_path, :error => "You must sign in."
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
    unless signed_in?
      redirect_to root_path, :error => "You must sign in."
    end
    @bounty = Bounty.find(params[:id])
    # The format parameter is a string passed along with the id when using
    # bounty_path. Ex. bounty_path(4, "Complete") would set @format to
    # "Complete", which the view will use to render the form for Completing a
    # bounty, maintaining REST.
    @format = params[:format]
    unless (@bounty.owner == currentUser || @bounty.has_candidate?(currentUser.name))
      redirect_to root_path, :error => "You are not authorized to edit this bounty."
    end
  end

  # Update the bounty. Artists that are candidates for the bounty may use this
  # for completion of a bounty. Owners of the bounty may edit all other
  # properties.
  def update
    unless signed_in?
      redirect_to root_path, :error => "You must sign in."
    end
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
    unless signed_in?
      redirect_to root_path, :error => "You must sign in."
    end
    @bounty = Bounty.find(params[:id])

    if (@bounty.owner == currentUser && (@bounty.status == 'Unclaimed')) || currentUser.admin?
      if Bounty.destroy(params[:id])
        redirect_to root_path, :notice => "Bounty successfully removed."
      else
        redirect_to root_path, :error => "Error removing bounty."
      end
    else
      if @bounty.owner != currentUser
        redirect_to root_path, :error => "You are not authorized to remove this bounty."
      elsif @bounty.status == "Accepted"
        acceptor = @bounty.accepting_artist.get_identifier
        redirect_to root_path, :error => "This bounty is being worked on by #{acceptor} and cannot be deleted."
      else
        redirect_to root_path, :error => "This bounty is #{@bounty.status} and cannot be deleted."
      end
    end
  end
end

