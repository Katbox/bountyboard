class CandidaciesController < ApplicationController

  include SessionsHelper

  # Update the the candidacy to "accept" a bounty. Only artists that have a
  # candidacy to the bounty in question may perform this action.
  def update
    unless signed_in?
      redirect_to root_path, :error => "You must sign in."
    end
    @bounty = Bounty.find(params[:id])
    redirect_to root_path, :error => "Only artists may accept bounties." if (currentUser.artist? == false)
    @candidacy = Candidacy.where(:artist_id => currentUser.id, :bounty_id => @bounty.id).first
    unless @candidacy.nil?
      params[:candidacy][:accepted_at] = Time.now
      if @candidacy.update_attributes(params[:candidacy])
        redirect_to root_path, :notice => "Bounty Accepted!"
      else
        redirect_to edit_bounty_path(@bounty.id), :error => "Error accepting bounty."
      end
    else
      redirect_to root_path, :error => "You are not a candidate for that bounty."
    end
  end

  # Remove a candidacy between the currently logged in artist and the specified
  # bounty.
  def destroy
    unless signed_in?
      redirect_to root_path, :error => "You must sign in."
    end
    @bounty = Bounty.find(params[:id])
    redirect_to root_path, :error => "Only artists may reject bounties." if (currentUser.artist? == false)
    @candidacy = Candidacy.where(:artist_id => currentUser.id, :bounty_id => @bounty.id).first
    unless @candidacy.nil?
      if @candidacy.destroy
        redirect_to root_path, :notice => "Candidacy removed!"
      else
        redirect_to edit_bounty_path(@bounty.id), :error => "Error removing candidacy."
      end
    else
      redirect_to root_path, :error => "You are not a candidate for that bounty."
    end
  end

end

