class BountiesController < ApplicationController

  include SessionsHelper

  def index
    @bounty = Bounty.all
    @bounty.sort_by{|e| e[:created_at]}
    @candidacy = Candidacy.all
  end

  def show
    @bounty = Bounty.find(params[:id])
  end

  def new
    @bounty = Bounty.new
  end

  def create
    @bounty = Bounty.new(params[:bounty])
    @bounty.owner = currentUser

    if @bounty.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @bounty = Bounty.find(params[:id])
  end

  def update
    @bounty = Bounty.find(params[:id])
    if @bounty.update_attributes(params[:bounty])
      redirect_to root_path
    else
      redirect_to edit_bounty_path(@bounty.id)
    end
  end

  def destroy
    @bounty = Bounty.find(params[:id])
    reasonsToDelete = ['Unclaimed', 'Rejected']
    if @bounty.owner == currentUser && reasonsToDelete.include?(@bounty.status)
      Bounty.destroy(params[:id])
    end
    redirect_to root_path
  end
end

