class CandidaciesController < ApplicationController

  include SessionsHelper

  # Update the the candidacy to "accept" a bounty. Only artists that have a
  # candidacy to the bounty in question may perform this action.
  def update
    unless signed_in?
      flash[:error] = "You must sign in."
      redirect_to root_path
    end
    @bounty = Bounty.find(params[:id])
    redirect_to root_path, :error => "Only artists may accept bounties." if (not currentUser.is_a?(Artist))
    @candidacy = Candidacy.where(:artist_id => currentUser.id, :bounty_id => @bounty.id).first
    unless @candidacy.nil?
      params[:candidacy][:accepted_at] = Time.now
      if @candidacy.update_attributes(candidacy_update_params)
        flash[:notice] = "Bounty Accepted!"
        redirect_to root_path
      else
        flash[:error] = "Error accepting bounty."
        redirect_to edit_bounty_path(@bounty.id)
      end
    else
      flash[:error] = "You are not a candidate for that bounty."
      redirect_to root_path
    end
  end

  # Remove a candidacy between the currently logged in artist and the specified
  # bounty.
  def destroy
    unless signed_in?
      flash[:error] = "You must sign in."
      redirect_to root_path
    end
    @bounty = Bounty.find(params[:id])
    flash[:error] = "You are not a candidate for that bounty."
    if (not currentUser.is_a?(Artist))
      flash[:error] = "Only artists may reject bounties."
      redirect_to root_path
    end
    @candidacy = Candidacy.where(:artist_id => currentUser.id, :bounty_id => @bounty.id).first
    unless @candidacy.nil?
      if @candidacy.destroy
        if @bounty.abandoned?
          if @bounty.destroy
            flash[:notice] = "Bounty & Candidacy removed!"
            redirect_to root_path
            #TODO Mail user that bounty was totally rejected.
            return
          end
        end
        flash[:notice] = "Candidacy removed!"
        redirect_to root_path
      else
        flash[:error] = "Error removing candidacy."
        redirect_to edit_bounty_path(@bounty.id)
      end
    else
      flash[:error] = "You are not a candidate for that bounty."
      redirect_to root_path
    end
  end

  private

    def candidacy_create_params
      params.require(:artist).permit(
        :bounty_id,
        :artist_id
      )
    end

    def candidacy_update_params
      params.require(:artist).permit(:accepted_at)
    end

end

