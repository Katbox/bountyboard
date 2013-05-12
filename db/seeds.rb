artist1 = User.new(:name => 'Artist1', :email => 'artist1@test.com')
artist1.save!

artist2 = User.new(:name => 'Artist2', :email => 'artist2@test.com')
artist2.save!

artist3 = User.new(:name => 'Artist3', :email => 'artist3@test.com')
artist3.save!

artist4 = User.new(:name => 'Artist4', :email => 'artist4@test.com')
artist4.save!

customer1 = User.new(:name => 'Customer1', :email => 'customer1@test.com')
customer1.save!

customer2 = User.new(:name => 'Customer2', :email => 'customer2@test.com')
customer2.save!

artist1Details = ArtistDetail.new(
  :bio => 'Artist 1 is a nice person who likes the Art Deco style.',
  :bountyRules => 'Bounties over $20 only, please.',
  :approved => true
)
artist1Details.save!
artist1.artist_detail_id = artist1Details.id
artist1.save!

artist2Details = ArtistDetail.new(
  :bio => 'Artist 2 is a withdrawn person who emerges periodically to draw mostly surrealist art.',
  :bountyRules => 'Surrealist art only!',
  :approved => true
)
artist2Details.save!
artist2.artist_detail_id = artist2Details.id
artist2.save!

artist3Details = ArtistDetail.new(
  :bio => 'Artist 3 is inquisitive and energetic, exploring new artistic styles all the time.',
  :bountyRules => 'I only accept major art projects, costing $50 or more.',
  :approved => true
)
artist3Details.save!
artist3.artist_detail_id = artist3Details.id
artist3.save!

artist4Details = ArtistDetail.new(
  :bio => 'Artist 4 is a complete tool who only draws still lifes.',
  :bountyRules => 'I\'m a troll *rargle blargle*.',
  :approved => false
)
artist4Details.save!
artist4.artist_detail_id = artist4Details.id
artist4.save!

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
  :desc => "I want a painting of a serene landscape, letting me enjoy the neauty and grandeur of nature in my living room. I want it to have a lake and be at sunset.",
  :price => 1000.00
)
bounty1.user_id = customer1.id
bounty1.url = "completed URL"
bounty1.save!

# A bounty created by customer 1, accepted by artist 1.
bounty2 = Bounty.new(
  :name => "Tapestry Design",
  :desc => "An intricate pattern for a rug design.",
  :price => 2000.00
)
bounty2.user_id = customer1.id
bounty2.save!

# A bounty created by customer 2, accepted by no one.
bounty3 = Bounty.new(
  :name => "Comic Character",
  :desc => "I want a picture of my character doing cool stuff! Lots of explosions!",
  :price => 60.00
)
bounty3.user_id = customer2.id
bounty3.save!

# A bounty created by customer 2, accepted by artist 2.
bounty4 = Bounty.new(
  :name => "Tattoo Design",
  :desc => "I need someone to make a design that I will hand over to a tattoo artist for inking on my arm.",
  :price => 35.50
)
bounty4.user_id = customer2.id
bounty4.save!

# A bounty created by customer 1, completed by artist 3.
bounty5 = Bounty.new(
  :name => "Cartoon Sketches",
  :desc => "Storyboarding sketches for my animated short.",
  :price => 45.00
)
bounty5.user_id = customer2.id
bounty5.url = "completed URL"
bounty5.save!

# A bounty created by customer 1, accepted by artist 4.
bounty6 = Bounty.new(
  :name => "My Little Pony Fan Art",
  :desc => "Cute art of my favorite show ever!",
  :price => 9999.99
)
bounty6.user_id = customer1.id
bounty6.save!

# A bounty created by customer 2, completed by artist 3.
bounty7 = Bounty.new(
  :name => "Swimsuit Design",
  :desc => "A cute, yet sexy melon pattern.",
  :price => 999.99
)
bounty7.user_id = customer2.id
bounty7.url = "completed URL"
bounty7.save!

# A bounty created by customer 2, accepted by artist 2.
bounty8 = Bounty.new(
  :name => "Seedy Adult Commission",
  :desc => "I'm totally not ashamed to make an adult commission public!",
  :price => 666.00,
  :rating => true
)
bounty8.user_id = customer2.id
bounty8.save!

# A bounty created by customer 1, rejected by artist 4.
bounty9 = Bounty.new(
  :name => "My Little Pony \"Fan Art\"",
  :desc => "Clop. Clop. Keep this private. Clop. Clop.",
  :price => 100.00,
  :rating => true,
  :is_private => true
)
bounty9.user_id = customer1.id
bounty9.reject_id = artist4.id
bounty9.save!

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

#Bounty 1 was completed by Artist 1
candidacy = Candidacy.new()
candidacy.artist_detail_id = artist1.id
candidacy.bounty_id = bounty1.id
candidacy.acceptor = true
candidacy.save!

#Bounty 1 could have been completed by Artist 2
candidacy = Candidacy.new()
candidacy.artist_detail_id = artist2.id
candidacy.bounty_id = bounty1.id
candidacy.save!

#Bounty 1 could have been completed by Artist 3
candidacy = Candidacy.new()
candidacy.artist_detail_id = artist3.id
candidacy.bounty_id = bounty1.id
candidacy.save!

#Bounty 1 could have been completed by Artist 4
candidacy = Candidacy.new()
candidacy.artist_detail_id = artist4.id
candidacy.bounty_id = bounty1.id
candidacy.save!

#Bounty 2 is being completed by Artist 1
candidacy = Candidacy.new()
candidacy.artist_detail_id = artist1.id
candidacy.bounty_id = bounty2.id
candidacy.acceptor = true
candidacy.save!

#Bounty 2 could have been completed by Artist 2
candidacy = Candidacy.new()
candidacy.artist_detail_id = artist2.id
candidacy.bounty_id = bounty2.id
candidacy.save!

#Bounty 2 could have been completed by Artist 3
candidacy = Candidacy.new()
candidacy.artist_detail_id = artist3.id
candidacy.bounty_id = bounty2.id
candidacy.save!

#Bounty 3 may be completed by Artist 1
candidacy = Candidacy.new()
candidacy.artist_detail_id = artist1.id
candidacy.bounty_id = bounty3.id
candidacy.save!

#Bounty 3 may be completed by Artist 2
candidacy = Candidacy.new()
candidacy.artist_detail_id = artist2.id
candidacy.bounty_id = bounty3.id
candidacy.save!

#Bounty 4 is being completed by Artist 2
candidacy = Candidacy.new()
candidacy.artist_detail_id = artist2.id
candidacy.bounty_id = bounty4.id
candidacy.acceptor = true
candidacy.save!

#Bounty 5 is being completed by Artist 3
candidacy = Candidacy.new()
candidacy.artist_detail_id = artist3.id
candidacy.bounty_id = bounty5.id
candidacy.acceptor = true
candidacy.save!

#Bounty 6 may be completed by Artist 4
candidacy = Candidacy.new()
candidacy.artist_detail_id = artist4.id
candidacy.bounty_id = bounty6.id
candidacy.acceptor = true
candidacy.save!

#Bounty 7 may be completed by Artist 3
candidacy = Candidacy.new()
candidacy.artist_detail_id = artist3.id
candidacy.bounty_id = bounty7.id
candidacy.acceptor = true
candidacy.save!

#Bounty 8 may be completed by Artist 2
candidacy = Candidacy.new()
candidacy.artist_detail_id = artist2.id
candidacy.bounty_id = bounty8.id
candidacy.acceptor = true
candidacy.save!

#Bounty 9 could have been completed by Artist 1
candidacy = Candidacy.new()
candidacy.artist_detail_id = artist1.id
candidacy.bounty_id = bounty9.id
candidacy.save!
