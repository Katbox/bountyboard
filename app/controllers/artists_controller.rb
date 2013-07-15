class ArtistsController < ApplicationController

  include SessionsHelper
  # require 'sanitize'

  # Display a list of all artists in the system, with links to see their
  # individual profiles.
  def index
    @artist = Artist.all
  end

  # Display an individual artist's profile.
  def show
    @artist = Artist.find(params[:id])
    acceptingCandidacies = Candidacy.where(
      'artist_id=? AND (accepted_at IS NOT NULL)',  @artist.id
    )
    @acceptedBounties = []
    @completedBounties = []
    acceptingCandidacies.each do |c|
      if c.bounty.status == "Completed"
        @completedBounties.append(c.bounty)
      else
        @acceptedBounties.append(c.bounty)
      end
    end
  end

  # Display the form to create a new artist. Only admins may perform this
  # action.
  def new
    unless signed_in?
      flash[:error] = "You must sign in."
      redirect_to root_path
    end
    if currentUser.admin?
      @artist = Artist.new
    else
      flash[:error] = "Only administrators can create new artists."
      redirect_to root_path
    end
  end

  # Create a new artist. Only admins may perform this action.
  def create
    unless signed_in?
      flash[:error] = "You must sign in."
      redirect_to root_path
    end
    if currentUser.admin?
      #TODO Figure out how approved fits into our workflow.
      params[:artist][:approved] = true
      params[:artist][:active] = true

      # Sanitize the name, bio, and bounty_rules fields for artists.
      # Clean name of all HTML, clean the rest using "Relaxed" method which
      # allows:
      #
      # "Allows an even wider variety of markup than BASIC, including images and
      # tables. Links are still limited to FTP, HTTP, HTTPS, and mailto
      # protocols, while images are limited to HTTP and HTTPS. In this mode,
      # rel="nofollow" is not added to links."

      params[:artist][:name] = Sanitize.clean(params[:artist][:name])
      params[:artist][:bio] = Sanitize.clean(params[:artist][:bio], Sanitize::Config::RELAXED)
      params[:artist][:bounty_rules] = Sanitize.clean(params[:artist][:bounty_rules], Sanitize::Config::RELAXED)

      @artist = Artist.new(params[:artist])
      if @artist.save
        flash[:notice] = "Artist created successfully!"
        redirect_to root_path
      else
        flash[:error] = "Error saving artist."
        render 'new'
      end
    else
      flash[:error] = "Only administrators can create new artists."
      redirect_to root_path
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
      flash[:error] = "You must sign in."
      redirect_to root_path
    end
    @artist = Artist.find(params[:id])
    unless (@artist == currentUser || currentUser.admin?)
      flash[:error] = "You are not authorized to edit this artist."
      redirect_to root_path
    end
    # Sanitize the name, bio, and bounty_rules fields for artists.
    # Clean name of all HTML, clean the rest using "Relaxed" method which
    # allows:
    #
    # "Allows an even wider variety of markup than BASIC, including images and
    # tables. Links are still limited to FTP, HTTP, HTTPS, and mailto
    # protocols, while images are limited to HTTP and HTTPS. In this mode,
    # rel="nofollow" is not added to links."

    params[:artist][:name] = Sanitize.clean(params[:artist][:name])
    params[:artist][:bio] = Sanitize.clean(params[:artist][:bio], Sanitize::Config::RELAXED)
    params[:artist][:bounty_rules] = Sanitize.clean(params[:artist][:bounty_rules], Sanitize::Config::RELAXED)
    if @artist.update_attributes(params[:artist])
      flash[:notice] = "Artist updated!"
      redirect_to root_path
    else
      flash[:error] = "Error updating artist."
      redirect_to root_path
    end
  end

  # Artists may not be deleted. Instead, an "active" property is set to false,
  # prventing an artist from participating in the system or being selected for
  # bounties.
  def destroy
    unless signed_in?
      flash[:error] = "You must sign in."
      redirect_to root_path
    end
    @artist = Artist.find(params[:id])
    if currentUser.admin?
      @artist.active = false
      if @artist.save
        flash[:notice] = "Artist #{@artist.name} is now inactive!"
        redirect_to root_path
      else
        flash[:error] = "Error deactivating artist."
        redirect_to root_path
      end
    else
      flash[:error] = "Only administrators can delete artists."
      redirect_to root_path
    end
  end
end
