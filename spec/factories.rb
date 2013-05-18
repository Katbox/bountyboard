FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
  end

  factory :artist, :class => :artist, :parent => :user do
    bio "This is my artist's biography."
    bounty_rules "These are the rules for my bounties."
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
    artist {[FactoryGirl.create(:artist)]}
  end

  factory :personality do
  end

  factory :vote do
  end

  factory :candidacy do
    acceptor false
    artist { FactoryGirl.create(:artist) }
  end

  factory :acceptor_candidacy, :parent => :candidacy do
    acceptor true
  end
end

