# -*- encoding : utf-8 -*-
class VotesController < ApplicationController

  require 'statistics2'
  include SessionsHelper
  include VotesHelper

  def create
    if signed_in?
      @vote = Vote.new(params[:vote])
      @vote.user_id = currentUser.id
      @bounty = Bounty.find(params[:bounty])
      @vote.bounty_id = @bounty.id
      if @vote.save
        update_bounty_scores
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
