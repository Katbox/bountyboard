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
    if not signedIn?
      redirect_to root_path, :error => "You must sign in to create a bounty."
      return
    end

    #If no specific artists were selected. Then create a candidacy to all artists.
    if params[:bounty][:artist_ids]==[""]
      id_array = []
      @artist = Artist.all
      @artist.each do |a|
        id_array.append(a.id.to_s)
      end
      params[:bounty][:artist_ids] = id_array
    end

    @bounty = Bounty.new(params[:bounty])
    @bounty.owner = currentUser

    if @bounty.save
      redirect_to root_path, :notice => "Bounty created successfully."
    else
      flash[:error] = "Error saving bounty."
      render 'new'
    end
  end

  def edit
    @bounty = Bounty.find(params[:id])
    unless (@bounty.owner == currentUser)
      flash[:error] = "You are not authorized to edit this bounty."
      redirect_to root_path
    end
  end

  def update
    @bounty = Bounty.find(params[:id])
    if @bounty.owner != currentUser
      redirect_to root_path, :error => "You are not authorized to edit this bounty."
    end
    if @bounty.update_attributes(params[:bounty])
      redirect_to root_path, :notice => "Bounty Updated!"
    else
      redirect_to edit_bounty_path(@bounty.id), :error => "Error updating bounty."
    end
  end

  def destroy
    @bounty = Bounty.find(params[:id])

    #Only admins and the bounty's owner may delete the bounty. But the bounty's
    #owner may only delete the bounty if it is unclaimed.
    if (@bounty.owner == currentUser && (@bounty.status == 'Unclaimed')) || currentUser.is_admin?)
      if Bounty.destroy(params[:id])
        flash[:notice] = "Bounty successfully removed."
      else
        flash[:error] = "Error removing bounty."
      end
    else
      if @bounty.owner != currentUser
        flash[:error] = "You are not authorized to remove this bounty."
      elsif @bounty.status == "Accepted"
        acceptor = @bounty.accepting_artist.get_identifier
        flash[:error] =<<message
"This bounty is being worked on by #{acceptor} and cannot be deleted. You will
need to contact #{acceptor} and ask that he or she release their claim to the
bounty."
message
      else
        flash[:error] = "This bounty is #{@bounty.status} and cannot be deleted."
      end
    end
    redirect_to root_path
  end
end

