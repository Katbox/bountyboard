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
        flash[:error] =P "Error saving favorite."
        redirect_to root_path
      end
    else
      flash[:error] = "You must sign in."
      redirect_to root_path
    end
  end

  def destroy
    if signed_in?
      if Favorite.destroy(params[:id])
        redirect_to root_path
      else
        flash[:error] = "Error removing favorite."
        redirect_to root_path
      end
    else
      flash[:error] = "You must sign in."
      redirect_to root_path
    end
  end
end
