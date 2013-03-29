user = User.new(:name => 'Artist1', :email => 'artist1@test.com')
user.id = 1
user.isArtist = true
user.save

user = User.new(:name => 'Artist2', :email => 'artist2@test.com')
user.id = 2
user.isArtist = true
user.save

user = User.new(:name => 'Artist3', :email => 'artist3@test.com')
user.id = 3
user.isArtist = true
user.save

user = User.new(:name => 'Artist4', :email => 'artist4@test.com')
user.id = 4
user.isArtist = true
user.save

user = User.new(:name => 'Customer1', :email => 'customer1@test.com')
user.id = 5
user.save

user = User.new(:name => 'Customer2', :email => 'customer2@test.com')
user.id = 6
user.save

mood = Mood.new(:name => "Practical")
mood.id = 1
mood.save

mood = Mood.new(:name => "Conservative")
mood.id = 2
mood.save

mood = Mood.new(:name => "Wild")
mood.id = 3
mood.save

mood = Mood.new(:name => "Colorful")
mood.id = 4
mood.save

mood = Mood.new(:name => "Cartoony")
mood.id = 5
mood.save

mood = Mood.new(:name => "Stylized")
mood.id = 6
mood.save

mood = Mood.new(:name => "Sexy")
mood.id = 7
mood.save

# A bounty created by customer 1, completed by artist 1.
bounty = Bounty.new(:name => "Landscape Painting", :desc => "I want a painting of a serene landscape, letting me enjoy the neauty and grandeur of nature in my living room. I want it to have a lake and be at sunset.", :price => 1000.00)
bounty.id = 1
bounty.user_id = 5
bounty.accept_id = 1
bounty.complete_id = 1
bounty.save

# A bounty created by customer 1, accepted by artist 1.
bounty = Bounty.new(:name => "Tapestry Design", :desc => "An intricate pattern for a rug design.", :price => 2000.00)
bounty.id = 2
bounty.user_id = 5
bounty.accept_id = 1
bounty.save

# A bounty created by customer 2, accepted by no one.
bounty = Bounty.new(:name => "Comic Character", :desc => "I want a picture of my character doing cool stuff! Lots of explosions!", :price => 60.00)
bounty.id = 3
bounty.user_id = 2
bounty.save

# A bounty created by customer 2, accepted by artist 2.
bounty = Bounty.new(:name => "Tattoo Design", :desc => "I need someone to make a design that I will hand over to a tattoo artist for inking on my arm.", :price => 35.50)
bounty.id = 4
bounty.user_id = 6
bounty.accept_id = 2
bounty.save

# A bounty created by customer 1, completed by artist 1.
bounty = Bounty.new(:name => "Cartoon Sketches", :desc => "Storyboarding sketches for my animated short.", :price => 45.00)
bounty.id = 5
bounty.user_id = 6
bounty.accept_id = 3
bounty.complete_id = 3
bounty.save

# A bounty created by customer 1, completed by artist 1.
bounty = Bounty.new(:name => "My Little Pony Fan Art", :desc => "Cute art of my favorite show ever!", :price => 9999.99)
bounty.id = 6
bounty.user_id = 5
bounty.accept_id = 3
bounty.save

# A bounty created by customer 2, completed by artist 4.
bounty = Bounty.new(:name => "Swimsuit Design", :desc => "A cute, yet sexy melon pattern.", :price => 999.99)
bounty.id = 7
bounty.user_id = 6
bounty.accept_id = 4
bounty.complete_id = 4
bounty.save

# A bounty created by customer 2, accepted by artist 4.
bounty = Bounty.new(:name => "Seedy Adult Commission", :desc => "I'm totally not ashamed to make an adult commission public!", :price => 666.00, :rating => true)
bounty.id = 8
bounty.user_id = 6
bounty.accept_id = 4
bounty.save

# A bounty created by customer 1, rejected by artist 4.
bounty = Bounty.new(:name => "My Little Pony \"Fan Art\"", :desc => "Clop. Clop. Keep this private. Clop. Clop.", :price => 100.00, :rating => true, :private => true)
bounty.id = 9
bounty.user_id = 5
bounty.reject_id = 4
bounty.save

#Bounty 1's moods
personality = Personality.new()
personality.id = 1
personality.bounty_id = 1
personality.mood_id = 2
personality.save
personality = Personality.new()
personality.id = 2
personality.bounty_id = 1
personality.mood_id = 4
personality.save

#Bounty 2's moods
personality = Personality.new()
personality.id = 3
personality.bounty_id = 2
personality.mood_id = 3
personality.save
personality = Personality.new()
personality.id = 4
personality.bounty_id = 2
personality.mood_id = 4
personality.save

#Bounty 3's moods
personality = Personality.new()
personality.id = 5
personality.bounty_id = 3
personality.mood_id = 5
personality.save
personality = Personality.new()
personality.id = 6
personality.bounty_id = 3
personality.mood_id = 6
personality.save

#Bounty 4's moods
personality = Personality.new()
personality.id = 7
personality.bounty_id = 4
personality.mood_id = 3
personality.save

#Bounty 5's moods
personality = Personality.new()
personality.id = 9
personality.bounty_id = 5
personality.mood_id = 1
personality.save
personality = Personality.new()
personality.id = 10
personality.bounty_id = 5
personality.mood_id = 5
personality.save

#Bounty 6's moods
personality = Personality.new()
personality.id = 11
personality.bounty_id = 6
personality.mood_id = 4
personality.save
personality = Personality.new()
personality.id = 12
personality.bounty_id = 6
personality.mood_id = 5
personality.save

#Bounty 1 may be completed by Artist 1
candidacy = Candidacy.new()
candidacy.id = 1
candidacy.user_id = 1
candidacy.bounty_id = 1
candidacy.save

#Bounty 1 may be completed by Artist 2
candidacy = Candidacy.new()
candidacy.id = 2
candidacy.user_id = 2
candidacy.bounty_id = 1
candidacy.save

#Bounty 1 may be completed by Artist 3
candidacy = Candidacy.new()
candidacy.id = 3
candidacy.user_id = 3
candidacy.bounty_id = 1
candidacy.save

#Bounty 1 may be completed by Artist 4
candidacy = Candidacy.new()
candidacy.id = 4
candidacy.user_id = 4
candidacy.bounty_id = 1
candidacy.save

#Bounty 2 may be completed by Artist 1
candidacy = Candidacy.new()
candidacy.id = 5
candidacy.user_id = 1
candidacy.bounty_id = 2
candidacy.save

#Bounty 2 may be completed by Artist 2
candidacy = Candidacy.new()
candidacy.id = 6
candidacy.user_id = 2
candidacy.bounty_id = 2
candidacy.save

#Bounty 2 may be completed by Artist 3
candidacy = Candidacy.new()
candidacy.id = 7
candidacy.user_id = 3
candidacy.bounty_id = 2
candidacy.save

#Bounty 3 may be completed by Artist 1
candidacy = Candidacy.new()
candidacy.id = 8
candidacy.user_id = 1
candidacy.bounty_id = 3
candidacy.save

#Bounty 3 may be completed by Artist 2
candidacy = Candidacy.new()
candidacy.id = 9
candidacy.user_id = 2
candidacy.bounty_id = 3
candidacy.save

#Bounty 4 may be completed by Artist 1
candidacy = Candidacy.new()
candidacy.id = 10
candidacy.user_id = 1
candidacy.bounty_id = 4
candidacy.save
