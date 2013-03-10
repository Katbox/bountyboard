User.create(:id => 1, :email => 'devin@test.com')
User.create(:id => 2, :email => 'brent@test.com')
User.create(:id => 3, :name => 'Artist1', :email => 'artist1@test.com')
User.create(:id => 4, :name => 'Artist2', :email => 'artist2@test.com')
User.create(:id => 5, :name => 'Artist3', :email => 'artist3@test.com')
User.create(:id => 6, :name => 'Artist4', :email => 'artist4@test.com')

Ip.create(:id => 3, :user_id => 3, :name => 'Artist1\'s IP', :desc => 'Practical stuff.', :rules => 'Anything goes.')
Ip.create(:id => 4, :user_id => 4, :name => 'Artist2\'s IP', :desc => 'Hippie stuff.', :rules => 'Amost anything goes.')
Ip.create(:id => 5, :user_id => 5, :name => 'Artist3\'s IP', :desc => 'Cool stuff.', :rules => 'I\'m a little picky.')
Ip.create(:id => 6, :user_id => 6, :name => 'Artist4\'s IP', :desc => 'Trendy stuff.', :rules => 'I\'m very picky.')

Vote.create(:user_id => 1, :bounty_id => 5)
Vote.create(:user_id => 2, :bounty_id => 1)

Mood.create(:id => 1, :name => "Sexy")
Mood.create(:id => 2, :name => "Comedy")
Mood.create(:id => 3, :name => "Action")
Mood.create(:id => 4, :name => "Artsy")
Mood.create(:id => 5, :name => "Cute")

Personality.create(:id =>1, :mood_id => 1, :bounty_id => 2)
Personality.create(:id =>1, :mood_id => 1, :bounty_id => 6)
Personality.create(:id =>1, :mood_id => 2, :bounty_id => 1)
Personality.create(:id =>1, :mood_id => 4, :bounty_id => 3)
Personality.create(:id =>1, :mood_id => 5, :bounty_id => 3)
Personality.create(:id =>1, :mood_id => 4, :bounty_id => 4)
Personality.create(:id =>1, :mood_id => 1, :bounty_id => 4)
Personality.create(:id =>1, :mood_id => 2, :bounty_id => 5)

#Bounty 1, Created by Devin, Accepted by Artist1.
Bounty.create(:id => 1, :user_id => 1, :accept_id => 3, :name => 'Comic Page', :desc => 'I want a comic page of my characters doing cool things!', :price => 100.00)

#Bounty 2, Created by Devin, Accepted by Artist1.
Bounty.create(:id => 2, :user_id => 1, :accept_id => 3, :name => 'Original Character', :desc => 'I want a commission of my own cool character.', :price => 15.50)

#Bounty 3, Created by Devin, Rejected by Artist1.
Bounty.create(:id => 3, :user_id => 1, :reject_id => 3, :name => 'Web Design', :desc => 'Please design my new webpage. I want it to be cool!', :price => 2000.00)

#Bounty 4, Created by Devin, Accepted by Artist2. Completed by Artist2.
Bounty.create(:id => 4, :user_id => 1, :accept_id => 4, :complete_id => 4,  :name => 'Fan Character', :desc => 'Could you draw your character with mine?', :url => 'http://www.4.com', :price => 25.00)

#Bounty 5, Created by Brent, Accepted by Artist3. Completed by Artist3.
Bounty.create(:id => 5, :user_id => 2, :accept_id => 5, :complete_id => 5, :name => 'Van Art', :desc => 'Dude... Could you paint a cougar on my van? That\'d be like, awesometacular!', :url => 'http://www.5.com', :price => 30.00)

#Bounty 6, Created by Brent, Accepted by Artist3. Completed by Artist3. Private.
Bounty.create(:id => 6, :user_id => 2, :accept_id => 5, :complete_id => 5, :name => 'Private Adult Commission', :desc => 'I\'m too shy to make this bounty public.', :url => 'http://www.6.com', :price => 100.00, :private => true)

#Bounty 1 may be completed by Artists 1-4
Candidacy.create(:id => 1, :user_id => 3, :bounty_id => 1)
Candidacy.create(:id => 2, :user_id => 4, :bounty_id => 1)
Candidacy.create(:id => 3, :user_id => 5, :bounty_id => 1)
Candidacy.create(:id => 4, :user_id => 6, :bounty_id => 1)

#Bounty 2 may be completed by Artists 1-2
Candidacy.create(:id => 5, :user_id => 3, :bounty_id => 2)
Candidacy.create(:id => 6, :user_id => 4, :bounty_id => 2)

#Bounty 3 may be completed by Artists 1 and 3.
Candidacy.create(:id => 7, :user_id => 3, :bounty_id => 3)
Candidacy.create(:id => 8, :user_id => 5, :bounty_id => 3)

#Bounty 4 may be completed by Artists 2 and 4.
Candidacy.create(:id => 9, :user_id => 4, :bounty_id => 4)
Candidacy.create(:id => 10, :user_id => 6, :bounty_id => 4)

#Bounty 5 may be completed by Artist 3.
Candidacy.create(:id => 11, :user_id => 5, :bounty_id => 5)

#Bounty 6 may be completed by Artist 3.
Candidacy.create(:id => 12, :user_id => 5, :bounty_id => 6)
