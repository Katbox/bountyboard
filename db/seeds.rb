require 'factory_girl_rails'

admin1 = User.new(
  :name => 'Admin1',
  :email => 'admin1@test.com',
)
admin1.admin = true
admin1.save!

artist1 = Artist.new(
  :name => 'Artist1',
  :email => 'artist1@test.com',
  :bio => 'Artist 1 is a nice person who likes the Art Deco style.',
  :bounty_rules => 'Bounties over $20 only, please.'
)
artist1.active = true
artist1.approved = true
artist1.save!

artist2 = Artist.new(
  :name => 'Artist2',
  :email => 'artist2@test.com',
  :bio => 'Artist 2 is a withdrawn person who emerges periodically to draw mostly surrealist art.',
  :bounty_rules => 'Surrealist art only!'
)
artist2.active = true
artist2.approved = true
artist2.save!

artist3 = Artist.new(
  :name => 'Artist3',
  :email => 'artist3@test.com',
  :bio => 'Artist 3 is inquisitive and energetic, exploring new artistic styles all the time.',
  :bounty_rules => 'I only accept major art projects, costing $50 or more.'
)
artist3.active = true
artist3.approved = true
artist3.save!

artist4 = Artist.new(
  :name => 'Artist4',
  :email => 'artist4@test.com',
  :bio => 'Artist 4 is a complete tool who only draws still lifes.',
  :bounty_rules => 'I\'m a troll *rargle blargle*.'
)
artist4.active = false
artist4.approved = false
artist4.save!

customer1 = User.new(:name => 'Customer1', :email => 'customer1@test.com')
customer1.save!

customer2 = User.new(:name => 'Customer2', :email => 'customer2@test.com')
customer2.save!

customer3 = User.new(:name => 'Customer3', :email => 'customer3@test.com')
customer3.save!

customer4 = User.new(:name => 'Customer4', :email => 'customer4@test.com')
customer4.save!

customer5 = User.new(:name => 'Customer5', :email => 'customer5@test.com')
customer5.save!

practicalMood = Mood.new(:name => "Practical")
practicalMood.save!

conservativeMood = Mood.new(:name => "Conservative")
conservativeMood.save!

wildMood = Mood.new(:name => "Wild")
wildMood.save!

colorfulMood = Mood.new(:name => "Colorful")
colorfulMood.save!

cartoonyMood = Mood.new(:name => "Cartoony")
cartoonyMood.save!

stylizedMood = Mood.new(:name => "Stylized")
stylizedMood.save!

sexyMood = Mood.new(:name => "Sexy")
sexyMood.save!

# A bounty created by customer 1, completed by artist 1.
bounty1 = Bounty.new(
  :name => "Landscape Painting",
  :tag_line => "I want a landscape painting.",
  :desc => "I want a painting of a serene landscape, letting me enjoy the neauty and grandeur of nature in my living room. I want it to have a lake and be at sunset.",
  :price => 1000.00
)
bounty1.user_id = customer1.id
bounty1.url = "http://nyquil.org/uploads/IndianHeadTestPattern16x9.png"
bounty1.completed_at = '2013-06-31 21:43:52 -0700'
bounty1.save!(:validate => false)

# A bounty created by customer 1, accepted by artist 1.
bounty2 = Bounty.new(
  :name => "Tapestry Design",
  :tag_line => "I want a Tapestry Design.",
  :desc => "An intricate pattern for a rug design.",
  :price => 2000.00
)
bounty2.user_id = customer1.id
bounty2.save!(:validate => false)

# A bounty created by customer 2, accepted by no one.
bounty3 = Bounty.new(
  :name => "Comic Character",
  :tag_line => "This tag_line is 160 characters long. This tag_line is 160 characters long. This tag_line is 160 characters long. This tag_line is 160 characters long......Now",
  :desc => "I want a picture of my character doing cool stuff! Lots of explosions!",
  :price => 60.00
)
bounty3.user_id = customer2.id
bounty3.save!(:validate => false)

# A bounty created by customer 2, accepted by artist 2.
bounty4 = Bounty.new(
  :name => "Tattoo Design",
  :tag_line => "I want tatoo design.",
  :desc => "I need someone to make a design that I will hand over to a tattoo artist for inking on my arm.",
  :price => 35.50
)
bounty4.user_id = customer2.id
bounty4.save!(:validate => false)

# A bounty created by customer 1, completed by artist 3.
bounty5 = Bounty.new(
  :name => "Cartoon Sketches",
  :tag_line => "I want cartoon sketches.",
  :desc => "Storyboarding sketches for my animated short.",
  :price => 45.00
)
bounty5.user_id = customer2.id
bounty5.url = "http://nyquil.org/uploads/IndianHeadTestPattern16x9.png"
bounty5.completed_at = '2013-06-31 21:43:52 -0700'
bounty5.save!(:validate => false)

# A bounty created by customer 1, accepted by artist 4.
bounty6 = Bounty.new(
  :name => "My Little Pony Fan Art",
  :tag_line => "I want art of my favorite show.",
  :desc => "Cute art of my favorite show ever!",
  :price => 9999.99
)
bounty6.user_id = customer1.id
bounty6.save!(:validate => false)

# A bounty created by customer 2, completed by artist 3.
bounty7 = Bounty.new(
  :name => "Swimsuit Design",
  :tag_line => "I want a pattern for a swimsuit.",
  :desc => "A cute, yet sexy melon pattern.",
  :price => 999.99
)
bounty7.user_id = customer2.id
bounty7.url = "http://nyquil.org/uploads/IndianHeadTestPattern16x9.png"
bounty7.completed_at = '2013-06-31 21:43:52 -0700'
bounty7.save!(:validate => false)

# A bounty created by customer 2, accepted by artist 2.
bounty8 = Bounty.new(
  :name => "Seedy Adult Commission",
  :tag_line => "I want something hard.",
  :desc => "I'm totally not ashamed to make an adult commission public!",
  :price => 666.00,
  :adult_only => true
)
bounty8.user_id = customer2.id
bounty8.save!(:validate => false)

# A bounty created by customer 1
bounty9 = Bounty.new(
  :name => "My Little Pony \"Fan Art\"",
  :tag_line => "I want something hard.",
  :desc => "Clop. Clop. Keep this private. Clop. Clop.",
  :price => 100.00,
  :adult_only => true,
  :private => true
)
bounty9.user_id = customer1.id
bounty9.save!(:validate => false)

#Bounty 1's moods
personality = Personality.new()
personality.bounty_id = bounty1.id
personality.mood_id = conservativeMood.id
personality.save!
personality = Personality.new()
personality.bounty_id = bounty1.id
personality.mood_id = colorfulMood.id
personality.save!

#Bounty 2's moods
personality = Personality.new()
personality.bounty_id = bounty2.id
personality.mood_id = wildMood.id
personality.save!
personality = Personality.new()
personality.bounty_id = bounty2.id
personality.mood_id = colorfulMood.id
personality.save!

#Bounty 3's moods
personality = Personality.new()
personality.bounty_id = bounty3.id
personality.mood_id = cartoonyMood.id
personality.save!
personality = Personality.new()
personality.bounty_id = bounty3.id
personality.mood_id = stylizedMood.id
personality.save!

#Bounty 4's moods
personality = Personality.new()
personality.bounty_id = bounty4.id
personality.mood_id = wildMood.id
personality.save!

#Bounty 5's moods
personality = Personality.new()
personality.bounty_id = bounty5.id
personality.mood_id = practicalMood.id
personality.save!
personality = Personality.new()
personality.bounty_id = bounty5.id
personality.mood_id = cartoonyMood.id
personality.save!

#Bounty 6's moods
personality = Personality.new()
personality.bounty_id = bounty6.id
personality.mood_id = colorfulMood.id
personality.save!
personality = Personality.new()
personality.bounty_id = bounty6.id
personality.mood_id = cartoonyMood.id
personality.save!

#Bounty 7's moods
personality = Personality.new()
personality.bounty_id = bounty7.id
personality.mood_id = sexyMood.id
personality.save!
personality = Personality.new()
personality.bounty_id = bounty7.id
personality.mood_id = colorfulMood.id
personality.save!

#Bounty 8's moods
personality = Personality.new()
personality.bounty_id = bounty8.id
personality.mood_id = sexyMood.id
personality.save!

#Bounty 9's moods
personality = Personality.new()
personality.bounty_id = bounty9.id
personality.mood_id = sexyMood.id
personality.save!

#Bounty 1 was completed by Artist 1
candidacy = Candidacy.new()
candidacy.artist = artist1
candidacy.bounty_id = bounty1.id
candidacy.accepted_at = '2013-05-31 21:43:52 -0700'
candidacy.save!

#Bounty 1 could have been completed by Artist 2
candidacy = Candidacy.new()
candidacy.artist = artist2
candidacy.bounty_id = bounty1.id
candidacy.save!

#Bounty 1 could have been completed by Artist 3
candidacy = Candidacy.new()
candidacy.artist = artist3
candidacy.bounty_id = bounty1.id
candidacy.save!

#Bounty 1 could have been completed by Artist 4
candidacy = Candidacy.new()
candidacy.artist = artist4
candidacy.bounty_id = bounty1.id
candidacy.save!

#Bounty 2 is being completed by Artist 1
candidacy = Candidacy.new()
candidacy.artist = artist1
candidacy.bounty_id = bounty2.id
candidacy.accepted_at = '2013-05-31 21:43:52 -0700'
candidacy.save!

#Bounty 2 could have been completed by Artist 2
candidacy = Candidacy.new()
candidacy.artist = artist2
candidacy.bounty_id = bounty2.id
candidacy.save!

#Bounty 2 could have been completed by Artist 3
candidacy = Candidacy.new()
candidacy.artist = artist3
candidacy.bounty_id = bounty2.id
candidacy.save!

#Bounty 3 may be completed by Artist 1
candidacy = Candidacy.new()
candidacy.artist = artist1
candidacy.bounty_id = bounty3.id
candidacy.save!

#Bounty 3 may be completed by Artist 2
candidacy = Candidacy.new()
candidacy.artist = artist2
candidacy.bounty_id = bounty3.id
candidacy.save!

#Bounty 4 is being completed by Artist 2
candidacy = Candidacy.new()
candidacy.artist = artist2
candidacy.bounty_id = bounty4.id
candidacy.accepted_at = '2013-05-31 21:43:52 -0700'
candidacy.save!

#Bounty 5 is being completed by Artist 3
candidacy = Candidacy.new()
candidacy.artist = artist3
candidacy.bounty_id = bounty5.id
candidacy.accepted_at = '2013-05-31 21:43:52 -0700'
candidacy.save!

#Bounty 6 may be completed by Artist 4
candidacy = Candidacy.new()
candidacy.artist = artist4
candidacy.bounty_id = bounty6.id
candidacy.accepted_at = '2013-05-31 21:43:52 -0700'
candidacy.save!

#Bounty 7 may be completed by Artist 3
candidacy = Candidacy.new()
candidacy.artist = artist3
candidacy.bounty_id = bounty7.id
candidacy.accepted_at = '2013-05-31 21:43:52 -0700'
candidacy.save!

#Bounty 8 may be completed by Artist 2
candidacy = Candidacy.new()
candidacy.artist = artist2
candidacy.bounty_id = bounty8.id
candidacy.accepted_at = '2013-05-31 21:43:52 -0700'
candidacy.save!

#Bounty 9 could have been completed by Artist 1
candidacy = Candidacy.new()
candidacy.artist = artist1
candidacy.bounty_id = bounty9.id
candidacy.save!

#Bounty 1 has an upvote vote on it from all customers.
vote = Vote.new()
vote.bounty_id = bounty1.id
vote.user_id = customer1.id
vote.vote_type = true
vote.save!

vote = Vote.new()
vote.bounty_id = bounty1.id
vote.user_id = customer2.id
vote.vote_type = true
vote.save!

vote = Vote.new()
vote.bounty_id = bounty1.id
vote.user_id = customer3.id
vote.vote_type = true
vote.save!

vote = Vote.new()
vote.bounty_id = bounty1.id
vote.user_id = customer4.id
vote.vote_type = true
vote.save!

vote = Vote.new()
vote.bounty_id = bounty1.id
vote.user_id = customer5.id
vote.vote_type = true
vote.save!

#Bounty 2 has an upvote vote on it from all but one customer.
vote = Vote.new()
vote.bounty_id = bounty2.id
vote.user_id = customer1.id
vote.vote_type = true
vote.save!

vote = Vote.new()
vote.bounty_id = bounty2.id
vote.user_id = customer2.id
vote.vote_type = true
vote.save!

vote = Vote.new()
vote.bounty_id = bounty2.id
vote.user_id = customer3.id
vote.vote_type = true
vote.save!

vote = Vote.new()
vote.bounty_id = bounty2.id
vote.user_id = customer4.id
vote.vote_type = true
vote.save!

vote = Vote.new()
vote.bounty_id = bounty2.id
vote.user_id = customer5.id
vote.vote_type = false
vote.save!

#Bounty 3 has an upvote vote on it from three customers.
vote = Vote.new()
vote.bounty_id = bounty3.id
vote.user_id = customer1.id
vote.vote_type = true
vote.save!

vote = Vote.new()
vote.bounty_id = bounty3.id
vote.user_id = customer2.id
vote.vote_type = true
vote.save!

vote = Vote.new()
vote.bounty_id = bounty3.id
vote.user_id = customer3.id
vote.vote_type = true
vote.save!

#Bounty 4 has an upvote vote on it from one customer. No one else likes it.
vote = Vote.new()
vote.bounty_id = bounty4.id
vote.user_id = customer1.id
vote.vote_type = true
vote.save!

vote = Vote.new()
vote.bounty_id = bounty4.id
vote.user_id = customer2.id
vote.vote_type = false
vote.save!

vote = Vote.new()
vote.bounty_id = bounty4.id
vote.user_id = customer3.id
vote.vote_type = false
vote.save!

vote = Vote.new()
vote.bounty_id = bounty4.id
vote.user_id = customer4.id
vote.vote_type = false
vote.save!

vote = Vote.new()
vote.bounty_id = bounty4.id
vote.user_id = customer5.id
vote.vote_type = false
vote.save!

#Resave to ensure validation.
bounty1.save!
bounty2.save!
bounty3.save!
bounty4.save!
bounty5.save!
bounty6.save!
bounty7.save!
bounty8.save!
bounty9.save!

# generate a bunch of random users
200.times do
  FactoryGirl.create(:user,
    :name => Faker::Name.name,
    :email => Faker::Internet.email
  )
end

# generate a bunch of random bounties
3000.times do
  FactoryGirl.create(:bounty,
    :owner => User.offset(rand(User.count)).first,
    :tag_line => Faker::Lorem.sentence(word_count = 4, supplemental = false),
    :desc => Faker::Lorem.paragraph,
    # generate a created_at date between about July 1, 2011 and June 23, 2013
    :created_at => DateTime.strptime(
      Random.rand(1309483481..1372027453).to_s, "%s"
    ),
    :artists => Artist
      .limit(Random.rand(1..Artist.count))
      .offset(rand(Artist.count))
      .all,
    :moods => Mood
      .limit(Random.rand(Personality.MINIMUM_MOODS..Personality.MAXIMUM_MOODS))
      .offset(rand(Mood.count))
      .all,
    :price => Random.rand(Bounty.MINIMUM_PRICE..Bounty.MAXIMUM_PRICE)
  )
end

