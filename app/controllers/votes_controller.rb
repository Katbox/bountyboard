class VotesController < ApplicationController

  require 'statistics2'
  include SessionsHelper

  def create
  end

  def destroy
  end

  def calculateConfidence(pos, n, confidence)
    if n == 0
      return 0
    end
    z = Statistics2.pnormaldist(1-(1-confidence)/2)
    phat = 1.0*pos/n
    (phat + z*z/(2*n) - z * Math.sqrt((phat*(1-phat)+z*z/(4*n))/n))/(1+z*z/n)
  end

end
