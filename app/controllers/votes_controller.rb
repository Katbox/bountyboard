class VotesController < ApplicationController

  include SessionsHelper

  def create
    if signed_in?
      @vote = Vote.new(vote_create_params)
      @vote.user = currentUser
      if @vote.save
        if @vote.vote_type == VoteType::Upvote
          flash[:notice] = "You have upvoted #{@vote.bounty.name}!"
        else
          flash[:notice] = "You have downvoted #{@vote.bounty.name}!"
        end
        redirect_to root_path
      else
        flash[:error] = "Error saving vote."
        redirect_to root_path
      end
    else
      flash[:error] = "You must sign in."
      redirect_to root_path
    end
  end

  def destroy
    if signed_in?
      if Vote.destroy(params[:id])
        redirect_to root_path
      else
        flash[:error] = "Error removing vote."
        redirect_to root_path
      end
    else
      flash[:error] = "You must sign in."
      redirect_to root_path
    end
  end

  private

    def vote_create_params
      params.require(:artist).permit(
        :bounty_id,
        :vote_type
      )
    end

end
