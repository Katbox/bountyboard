class BountiesController < ApplicationController

  include SessionsHelper

  def index
    @bounty = Bounty.all
    @bounty.sort_by{|e| e[:created_at]}
    @candidacy = Candidacy.all
  end

  def show
    # TODO: display the bounty
    @bounty = Bounty.find(params[:id])
  end

  def new
    @bounty = Bounty.new
    @artists = ArtistDetail.all
    @moods = Mood.all
  end

  def create
    #TODO Implement candidacy.
    @bounty = Bounty.new(params[:bounty])
    @bounty.owner = currentUser

    if @bounty.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    # TODO: display a page with a form for updating a bounty
    # make sure only the user that created the bounty can use this method
    bounty_to_update = Bounty.find(params[:id])
  end

  def update
    # TODO: replace an existing bounty with a new one
    # make sure only the user that created the bounty can use this method
    bounty_to_replace = Bounty.find(params[:id])
  end

  def destroy
    # destroy the specified bounty
    # TODO: make sure only the user that created the bounty can use this
    # method
    Bounty.destroy(params[:id])
  end
end
