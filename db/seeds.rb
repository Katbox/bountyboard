User.create(:id => 1, :name => 'Devin', :email => 'devin@test.com', :permission_id => 1)
User.create(:id => 2, :name => 'Brent', :email => 'brent@test.com', :permission_id => 3)
User.create(:id => 3, :name => 'Artist1', :email => 'artist1@test.com', :permission_id => 2)
User.create(:id => 4, :name => 'Artist2', :email => 'artist2@test.com', :permission_id => 2)
User.create(:id => 5, :name => 'Artist3', :email => 'artist3@test.com', :permission_id => 2)
User.create(:id => 6, :name => 'Artist4', :email => 'artist4@test.com', :permission_id => 2)

Ip.create(:id => 3, :user_id => 3, :name => 'Artist1\'s IP', :desc => 'Practical stuff.', :rules => 'Anything goes.')
Ip.create(:id => 4, :user_id => 4, :name => 'Artist2\'s IP', :desc => 'Hippie stuff.', :rules => 'Amost anything goes.')
Ip.create(:id => 5, :user_id => 5, :name => 'Artist3\'s IP', :desc => 'Cool stuff.', :rules => 'I\'m a little picky.')
Ip.create(:id => 6, :user_id => 6, :name => 'Artist4\'s IP', :desc => 'Trendy stuff.', :rules => 'I\'m very picky.')

Permission.create(:id => 1, :name => 'basic_user')
Permission.create(:id => 2, :name => 'artist')
Permission.create(:id => 3, :name => 'administrator')

#Bounty 1, Created by Devin, Accepted by Artist1.
Bounty.create(:id => 1, :user_id => 1, :accept_id => 3, :name => 'Bounty1', :desc => 'This is bounty 1.', :price => 10.00, :vote => 0)

#Bounty 2, Created by Devin, Accepted by Artist1.
Bounty.create(:id => 2, :user_id => 1, :accept_id => 3, :name => 'Bounty2', :desc => 'This is bounty 2.', :price => 15.00, :vote => 0)

#Bounty 3, Created by Devin, Rejected by Artist1.
Bounty.create(:id => 3, :user_id => 1, :reject_id => 3, :name => 'Bounty3', :desc => 'This is bounty 3.', :price => 20.00, :vote => 0)

#Bounty 4, Created by Devin, Accepted by Artist2. Completed by Artist2.
Bounty.create(:id => 4, :user_id => 1, :accept_id => 4, :complete_id => 4, :name => 'Bounty4', :desc => 'This is bounty 4.', :price => 25.00, :vote => 0)

#Bounty 5, Created by Brent, Accepted by Artist3. Completed by Artist3.
Bounty.create(:id => 5, :user_id => 2, :accept_id => 5, :complete_id => 5, :name => 'Bounty5', :desc => 'This is bounty 5.', :price => 30.00, :vote => 0)

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
Candidacy.create(:id => 11, :user_id => 5, :bounty_id => 4)



