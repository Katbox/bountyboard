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
  
  factory :bounty do
    sequence(:name) { |n| "bounty#{n}" }
    desc "Bounty description."
	price_cents 500
    user_id {[FactoryGirl.create(:user)]}
  end
  
  factory :personality, :parent => :bounty do
    moods {[FactoryGirl.create(:mood)]}
  end
  
  factory :candidacy, :parent => :artist_detail do
    bounties {[FactoryGirl.create(:bounty)]}
  end
end

