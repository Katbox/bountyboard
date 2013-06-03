class ArtistsController < ApplicationController

  include SessionsHelper

  def index
  end

  def show
      @artist = Artist.find(params[:id])
      candidacies = Candidacy.where(:artist_id => currentUser.id, :acceptor => true)
      @bounties = []
      candidacies.each do |c|
        @bounties.append(c.bounty)
      end
  end

  def new
    unless signed_in?
      redirect_to root_path, :error => "You must sign in."
      return
    end
    if currentUser.admin?
      @artist = Artist.new
    else
      redirect_to root_path, :error => "Only administrators can create new artists."
    end
  end

  def create
    unless signed_in?
      redirect_to root_path, :error => "You must sign in."
      return
    end
    if currentUser.admin?
      #Auto approve for now.
      params[:artist][:approved] = true
      @artist = Artist.new(params[:artist])
      if @artist.save
        redirect_to root_path, :notice => "Artist created successfully."
      else
        flash[:error] = "Error saving Artist."
        render 'new'
      end
    else
      redirect_to root_path, :error => "Only administrators can create new artists."
    end
  end

  def edit
    @artist = Artist.find(params[:id])
    unless (@artist == currentUser || currentUser.admin?)
      flash[:error] = "You are not authorized to edit this artist."
      redirect_to root_path
    end
  end

  def update
    @artist = Artist.find(params[:id])
    unless (@artist == currentUser || currentUser.admin?)
      redirect_to root_path, :error => "You are not authorized to edit this artist."
    end
    if @artist.update_attributes(params[:artist])
      redirect_to root_path, :notice => "Artist Updated!"
    else
      redirect_to root_path, :error => "Error updating Artist."
    end
  end

  def destroy
    @artist = Artist.find(params[:id])
    if currentUser.admin?
      @artist.active = false
      if @artist.save
        redirect_to root_path, :notice => "Artist #{@artist.name} is now inactive."
      else
        redirect_to root_path, :error => "Error deactivating Artist."
      end
    else
      redirect_to root_path, :error => "Only administrators can delete artists."
    end
  end
end
