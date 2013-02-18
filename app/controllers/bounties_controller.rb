class BountiesController < ApplicationController
	def index
		@bounties = Bounty.all
	end

	def show
		# TODO: display the bounty
		@bounty = Bounty.find(params[:id])
	end

	def new
		@bounty = Bounty.new
	end

	def create
		# TODO: create a new bounty from the passed parameters
		# make sure only logged in users can use this method
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

