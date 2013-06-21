class VotesController < ApplicationController

  require 'statistics2'
  include SessionsHelper

  def create
    if signed_in?
      @vote = Vote.new(params[:vote])
      @vote.user_id = currentUser.id
      @bounty = Bounty.find(params[:bounty])
      @vote.bounty_id = @bounty.id
      if @vote.save

        #Variables required for "Lower bound of Wilson score confidence interval
        #for a Bernoulli parameter"
        pos = Vote.where(:bounty_id => @bounty.id :vote_type => true).count
        n = Vote.where(:bounty_id => @bounty.id).count
        #Magic number indicating 95% confidence level.
        confidence = 0.95
        @bounty.setRating(pos, n, confidence)
        @bounty.save

        if @vote.vote_type
          flash[:notice] = "You have upvoted #{@bounty.name}!"
        else
          flash[:notice] = "You have downvoted #{@bounty.name}!"
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
end
