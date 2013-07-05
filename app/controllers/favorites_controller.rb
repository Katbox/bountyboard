class FavoritesController < ApplicationController

  include SessionsHelper

  def create
    if signed_in?
      @favorite = Favorite.new()
      @favorite.user = currentUser
      @favorite.bounty = Bounty.find(params[:bounty])
      if @favorite.save
        flash[:notice] = "You have favorited #{@favorite.bounty.name}!"
        redirect_to root_path
      else
        flash[:error] = "Error saving favorite."
        redirect_to root_path
      end
    else
      flash[:error] = "You must sign in."
      redirect_to root_path
    end
  end
end
