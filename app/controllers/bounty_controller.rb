class BountyController < ApplicationController
	def index
		@bounties = Bounty.all
	end

	def new
		@bounty = Bounty.new
	end

	def showAll
		@bounties = Bounty.all
	end
end
