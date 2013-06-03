class ArtistsController < ApplicationController

  include SessionsHelper

  # Display a list of all artists in the system, with links to see their
  # individual profiles.
  def index
    @artist = Artist.all
  end

  # Display an individual artist's profile.
  def show
      @artist = Artist.find(params[:id])
      candidacies = Candidacy.where(:artist_id => currentUser.id, :acceptor => true)
      @bounties = []
      candidacies.each do |c|
        @bounties.append(c.bounty)
      end
  end

  # Display the form to create a new artist. Only admins may perform this
  # action.
  def new
    unless signed_in?
      redirect_to root_path, :error => "You must sign in."
    end
    if currentUser.admin?
      @artist = Artist.new
    else
      redirect_to root_path, :error => "Only administrators can create new artists."
    end
  end

  # Create a new artist. Only admins may perform this action.
  def create
    unless signed_in?
      redirect_to root_path, :error => "You must sign in."
    end
    if currentUser.admin?
      #TODO Figure out how approved fits into our workflow.
      params[:artist][:approved] = true
      @artist = Artist.new(params[:artist])
      if @artist.save
        redirect_to root_path, :notice => "Artist created successfully!"
      else
        flash[:error] = "Error saving artist."
        render 'new'
      end
    else
      redirect_to root_path, :error => "Only administrators can create new artists."
    end
  end

  # Display the edit form for the currently logged in artist or for an
  # administrator.
  def edit
    unless signed_in?
      redirect_to root_path, :error => "You must sign in."
    end
    @artist = Artist.find(params[:id])
    unless (@artist == currentUser || currentUser.admin?)
      flash[:error] = "You are not authorized to edit this artist."
      redirect_to root_path
    end
  end

  # Update the currently logged in artist. Admins are allowed to update artist
  # properties.
  def update
    unless signed_in?
      redirect_to root_path, :error => "You must sign in."
    end
    @artist = Artist.find(params[:id])
    unless (@artist == currentUser || currentUser.admin?)
      redirect_to root_path, :error => "You are not authorized to edit this artist."
    end
    if @artist.update_attributes(params[:artist])
      redirect_to root_path, :notice => "Artist updated!"
    else
      redirect_to root_path, :error => "Error updating artist."
    end
  end

  # Artists may not be deleted. Instead, an "active" property is set to false,
  # prventing an artist from participating in the system or being selected for
  # bounties.
  def destroy
    unless signed_in?
      redirect_to root_path, :error => "You must sign in."
    end
    @artist = Artist.find(params[:id])
    if currentUser.admin?
      @artist.active = false
      if @artist.save
        redirect_to root_path, :notice => "Artist #{@artist.name} is now inactive!"
      else
        redirect_to root_path, :error => "Error deactivating artist."
      end
    else
      redirect_to root_path, :error => "Only administrators can delete artists."
    end
  end
end
