User.create(:name => 'Alice', :email => 'Alice@gmail.com')
User.create(:name => 'Bob', :email => 'Bob@gmail.com')
User.create(:name => 'Carol', :email => 'Carol@gmail.com')

Artist.create(:name => 'Douglas', :email => 'Douglas@gmail.com', :password => 'abc123', :desc => 'My name starts with a D.', :rules => 'Im very specific as to what I will do.')
Artist.create(:name => 'Earl', :email => 'Earl@gmail.com', :password => 'abc123', :desc => 'My name starts with an E.', :rules => 'Im ok with some things.')
Artist.create(:name => 'Frank', :email => 'Frank@gmail.com', :password => 'abc123', :desc => 'My name starts with an F.', :rules => 'Anything goes.')

Status.create(:status => 'Unclaimed')
Status.create(:status => 'Accepted')
Status.create(:status => 'Completed')
Status.create(:status => 'Rejected')

Taxonomy.create(:name => 'has_accepted')
Taxonomy.create(:name => 'has_rejected')
Taxonomy.create(:name => 'has_completed')
Taxonomy.create(:name => 'may_complete')

Bounty.create(:name => 'Job 1', :desc => 'A simple job.', :price => 10.00, :rating => "Simple and Clean", :vote => 0, :user_id => 1)
Bounty.create(:name => 'Job 2', :desc => 'A strange job.', :price => 16.01, :rating => "Strange and Creepy", :vote => 5, :user_id => 2)
Bounty.create(:name => 'Job 3', :desc => 'A crazy hard job.', :price => 999.99, :rating => "Super Hard", :vote => 100, :url => 'www.google.com', :user_id => 3)
Bounty.create(:name => 'Job 4', :desc => 'A crappy job.', :price => 999.99, :rating => "Crappy", :vote => -5, :user_id => 3)

Ip.create(:name => 'Las Lindas', :desc => 'A cowgirl and her farm.', :rules => 'Almost anything goes.', :artist_id => 1)

Completion.create(:artist_id => 1, :bounty_id => 1, :taxonomy_id => 4)
Completion.create(:artist_id => 2, :bounty_id => 1, :taxonomy_id => 4)
Completion.create(:artist_id => 3, :bounty_id => 1, :taxonomy_id => 4)

Completion.create(:artist_id => 1, :bounty_id => 2, :taxonomy_id => 4)
Completion.create(:artist_id => 2, :bounty_id => 2, :taxonomy_id => 4)
Completion.create(:artist_id => 3, :bounty_id => 2, :taxonomy_id => 4)

Completion.create(:artist_id => 1, :bounty_id => 3, :taxonomy_id => 4)
Completion.create(:artist_id => 2, :bounty_id => 3, :taxonomy_id => 4)
Completion.create(:artist_id => 3, :bounty_id => 3, :taxonomy_id => 4)

Completion.create(:artist_id => 1, :bounty_id => 4, :taxonomy_id => 4)
Completion.create(:artist_id => 2, :bounty_id => 4, :taxonomy_id => 4)
Completion.create(:artist_id => 3, :bounty_id => 4, :taxonomy_id => 4)

Completion.create(:artist_id => 1, :bounty_id => 1, :taxonomy_id => 1)
Completion.create(:artist_id => 2, :bounty_id => 2, :taxonomy_id => 1)
Completion.create(:artist_id => 3, :bounty_id => 3, :taxonomy_id => 1)
Completion.create(:artist_id => 3, :bounty_id => 3, :taxonomy_id => 3)
Completion.create(:artist_id => 3, :bounty_id => 4, :taxonomy_id => 2)

