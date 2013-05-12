FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
  end

  factory :user_with_artist_detail, :parent => :user do
    artist_detail_id { FactoryGirl.create(:artist_detail) }
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
    user_id {FactoryGirl.create(:user)}
    after(:build) do |bounty|
	  bounty.moods {[FactoryGirl.create(:mood)]}
	end
  end

  factory :bounty_with_candidacy, :parent => :bounty do
    artist_details {[FactoryGirl.create(:artist_detail)]}
  end
  
  factory :personality do
  end
  
  factory :candidacy do
	acceptor false
    artist_detail_id { FactoryGirl.create(:artist_detail) }
  end

  factory :acceptor_candidacy, :parent => :candidacy do
    acceptor true
  end
end

