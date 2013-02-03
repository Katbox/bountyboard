class BoardController < ApplicationController
  def index
  	@bounties = Bounty.all
  	@candidacies = Candidacy.all
  end
end
