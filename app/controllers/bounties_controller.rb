class BountiesController < ApplicationController
	def index
		@bounty = Bounty.all
		@candidacy = Candidacy.all
	end

	def show
		# TODO: display the bounty
		@bounty = Bounty.find(params[:id])
	end

	def new
		@bounty = Bounty.new
		@moods = Mood.all
	end

	def create
		@bounty = Bounty.new(params[:bounty])
		@bounty.user_id = 1
		if @bounty.save
			render index
		else
			render 'new'
		end
	end

	def edit
		# TODO: display a page with a form for updating a bounty
		# make sure only the user that created the bounty can use this method
		bounty_to_update = Bounty.find(params[:id])
	end

	def update
		# TODO: replace an existing bounty with a new one
		# make sure only the user that created the bounty can use this method
		bounty_to_replace = Bounty.find(params[:id])
	end

	def destroy
		# destroy the specified bounty
		# TODO: make sure only the user that created the bounty can use this
		# method
		Bounty.destroy(params[:id])
	end
end

