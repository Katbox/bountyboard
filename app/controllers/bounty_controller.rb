class BountyController < ApplicationController
	def index
		@bounties = Bounty.all
	end
end
