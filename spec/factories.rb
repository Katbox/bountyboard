FactoryGirl.define do

  factory :user, :aliases => [:owner] do
    sequence(:email) { |n| "user#{n}@example.com" }

    trait :admin do
      admin true
    end
  end

  factory :artist, :class => :artist, :parent => :user do
    sequence(:email) { |n| "artist#{n}@example.com" }
    sequence(:name) { |n| "artist#{n}" }
    bio "This is my artist's biography."
    bounty_rules "These are the rules for my bounties."
    approved true
    active true
  end

  factory :mood do
    sequence(:name) { |n| "mood#{n}" }
  end

  factory :favorite do
    user
    bounty
  end

  factory :vote do
    user
    bounty
  end

  factory :bounty do
    sequence(:name) { |n| "bounty#{n}" }
    tag_line "Bounty Tag Line."
    desc "Bounty description."
    price Bounty.MINIMUM_PRICE
    owner
    moods {[FactoryGirl.create(:mood)]}
    artists {[FactoryGirl.create(:artist)]}

    trait :private do
      private true
    end
  end

  factory :personality do
    bounty
    mood
  end

  factory :candidacy do
    bounty
    artist
  end
end

