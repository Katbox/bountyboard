class CandidaciesController < ApplicationController

  include SessionsHelper

  # def index
  # end

  # def show
  # end

  # def new
  # end

  # def create
  # end

  # def edit
  # end

  def update
    @bounty = Bounty.find(params[:id])
    redirect_to root_path, :error => "Only artists may accept bounties." if (currentUser.is_artist? == false)
    @candidacy = Candidacy.where(:artist_id => currentUser.id, :bounty_id => @bounty.id).first
    unless @candidacy.nil?
      if @candidacy.update_attributes(params[:candidacy])
        redirect_to root_path, :notice => "Bounty Accepted!"
      else
        redirect_to edit_bounty_path(@bounty.id), :error => "Error Accepting bounty."
      end
    else
      redirect_to root_path, :error => "You are not a candidate for that bounty."
    end
  end

  def destroy
    @bounty = Bounty.find(params[:id])
    redirect_to root_path, :error => "Only artists may reject bounties." if (currentUser.is_artist? == false)
    @candidacy = Candidacy.where(:artist_id => currentUser.id, :bounty_id => @bounty.id).first
    unless @candidacy.nil?
      if @candidacy.destroy
        redirect_to root_path, :notice => "Candidacy Removed!"
      else
        redirect_to edit_bounty_path(@bounty.id), :error => "Error Removing Candidacy."
      end
    else
      redirect_to root_path, :error => "You are not a candidate for that bounty."
    end
  end

end

