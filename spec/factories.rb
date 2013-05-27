# coding: utf-8

FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
  end

  factory :artist, :class => :artist, :parent => :user do
    sequence(:name) { |n| "artist#{n}@example.com" }
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
      (1..Personality.MINIMUM_MOODS).each do
        bounty.moods.append(FactoryGirl.create(:mood))
      end
    end
  end

  factory :bounty_with_candidacy, :parent => :bounty do
    artists {[FactoryGirl.create(:artist)]}
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

