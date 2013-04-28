FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
  end
  
  factory :artist_detail do
    bio "This is my artist's biography."
    bountyRules "These are the rules for my bounties."
  end
  
  factory :mood do
    sequence(:name) { |n| "mood#{n}" }
  end

  factory :mood_with_bounty, :parent => :mood do
    bounties {[FactoryGirl.create(:bounty)]}
  end
  
  factory :bounty do
    sequence(:name) { |n| "bounty#{n}" }
    desc "Bounty description."
	price_cents 500
    user_id {[FactoryGirl.create(:user)]}
  end

  factory :bounty_with_mood, :parent => :bounty do
    moods {[FactoryGirl.create(:mood)]}
  end
  
  factory :personality do
  end
  
  factory :candidacy do
    bounty_id {[FactoryGirl.create(:bounty)]}
	artist_detail_id {[FactoryGirl.create(:artist_detail)]}
	acceptor false
  end

  factory :acceptor_candidacy, :parent => :candidacy do
    acceptor true
  end
end

