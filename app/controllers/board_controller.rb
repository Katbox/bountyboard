# encoding: UTF-8

class BoardController < ApplicationController
  def index
  	@bounties = Bounty.all
  end
end
