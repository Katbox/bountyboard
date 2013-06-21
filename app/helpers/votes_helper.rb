module VotesHelper
  def update_bounty_scores
    bounties = Bounty.all
    bounties.each do |b|
      #Variables required for "Lower bound of Wilson score confidence interval
      #for a Bernoulli parameter"
      pos = Vote.where(:bounty_id => b.id, :vote_type => true).count
      n = Vote.where(:bounty_id => b.id).count
      #Magic number indicating 95% confidence level.
      confidence = 0.95
      b.setRating(pos, n, confidence)
      b.save
    end
  end
end
