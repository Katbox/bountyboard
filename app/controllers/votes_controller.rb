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
        if params[:vote][:vote_type]
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

  def destroy
  end

  def calculateConfidence(pos, n, confidence)
    if n == 0
      return 0
    end
    z = Statistics2.pnormaldist(1-(1-confidence)/2)
    phat = 1.0*pos/n
    (phat + z*z/(2*n) - z * Math.sqrt((phat*(1-phat)+z*z/(4*n))/n))/(1+z*z/n)
  end

end
