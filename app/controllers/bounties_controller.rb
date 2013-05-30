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

    #If an "accept" parameter was passed, we need to intercept it because it's
    #part of the bounty model and you shouldn't call "update attributes" on it.
    if params[:bounty][:accept]
      #If the user that initiated this action is an artist...
      if currentUser.type == 'Artist'
        #And they are a candidate for the bounty...
        targetCandidacy = Candidacy.where(:artist_id => currentUser.id, :bounty_id => @bounty.id).first
        if targetCandidacy
          #Mark them as the acceptor.
          targetCandidacy.acceptor = true
          if targetCandidacy.save
            redirect_to root_path, :notice => "Bounty Accepted!"
          else
            redirect_to root_path, :error => "Error updating candidacy."
          end
        else
          redirect_to root_path, :error => "You are not a candidate for that bounty."
        end
      else
        redirect_to root_path, :error => "Only artists may accept bounties."
      end
    #Otherwise, update the remainder of the bounty parameters.
    else
      if @bounty.owner != currentUser
        redirect_to root_path, :error => "You are not authorized to edit this bounty."
      end
      if @bounty.update_attributes(params[:bounty])
        redirect_to root_path, :notice => "Bounty Updated!"
      else
        redirect_to edit_bounty_path(@bounty.id), :error => "Error updating bounty."
      end
    end
  end

  def destroy
    @bounty = Bounty.find(params[:id])
    reasonsToDelete = ['Unclaimed', 'Rejected']
    if @bounty.owner == currentUser && reasonsToDelete.include?(@bounty.status)
      if Bounty.destroy(params[:id])
        flash[:notice] = "Bounty successfully removed."
      else
        flash[:error] = "Error removing bounty."
      end
    else
      if @bounty.owner == currentUser
        flash[:error] = "You are not authorized to remove this bounty."
      else
        if @bounty.status == "Accepted"
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
    end
    redirect_to root_path
  end
end

