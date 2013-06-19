# -*- encoding : utf-8 -*-

FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
  end

  factory :artist, :class => :artist, :parent => :user do
    sequence(:name) { |n| "artist#{n}" }
    bio "This is my artist's biography."
    bounty_rules "These are the rules for my bounties."
    approved true
    active true
  end

  factory :mood do
    sequence(:name) { |n| "mood#{n}" }
  end

  factory :vote do
  end

  factory :bounty do
  sequence(:name) { |n| "bounty#{n}" }
  desc "Bounty description."
  price Bounty.MINIMUM_PRICE
  user_id {FactoryGirl.create(:user)}
  after(:build) do |bounty|
      (1..Personality.MINIMUM_MOODS).each do
        bounty.moods.append(FactoryGirl.create(:mood))
      end
      (1..3).each do
        bounty.artists.append(FactoryGirl.create(:artist))
      end
    end
  end

  factory :personality do
  end

  factory :candidacy do
    acceptor false
    artist { FactoryGirl.create(:artist) }
  end

  factory :acceptor_candidacy, :parent => :candidacy do
    acceptor true
  end

  factory :filter_template do
    sequence(:name) { |n| "filter#{n}" }
    sql 'pwn DROP TABLE VALJ'
  end
end

