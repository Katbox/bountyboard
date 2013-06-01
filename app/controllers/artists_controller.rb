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
    if currentUser.is_admin?
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
    if currentUser.is_admin?
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
  end

  def update
  end

  def destroy
    @artist = Artist.find(params[:id])
    if currentUser.is_admin?
      @artist.active = false
      redirect_to root_path, :notice => "Artist #{@artist.name} is now inactive."
    else
      redirect_to root_path, :error => "Only administrators can delete artists."
    end
  end
end
