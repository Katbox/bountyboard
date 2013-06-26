# -*- encoding : utf-8 -*-

FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
  end

  factory :admin, :parent => :user do
    sequence(:name) { |n| "admin#{n}" }
    admin true
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
    user {FactoryGirl.create(:user)}
    bounty {FactoryGirl.create(:bounty)}
  end

  factory :bounty do
    sequence(:name) { |n| "bounty#{n}" }
    desc "Bounty description."
    price Bounty.MINIMUM_PRICE
    owner {FactoryGirl.create(:user)}
    moods {[FactoryGirl.create(:mood)]}
    artists {[FactoryGirl.create(:artist)]}
  end

  factory :bounty_with_vote, :parent => :bounty do
    votes {[FactoryGirl.create(:vote)]}
  end

  factory :private_bounty, :parent => :bounty do
    private true
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

