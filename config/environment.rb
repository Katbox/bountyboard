# Load the rails application
require File.expand_path('../application', __FILE__)

# Adding in our custom time formatting

Time::DATE_FORMATS[:created_on] = "Created on %B %d %Y"
Time::DATE_FORMATS[:accepted_on] = "Accepted on %B %d %Y"
Time::DATE_FORMATS[:completed_on] = "Completed on %B %d %Y"
Time::DATE_FORMATS[:joined_on] = "Joined on %B %d %Y"
Time::DATE_FORMATS[:complete_by] = "This bounty must be finished by %B %d %Y"

# Initialize the rails application
Bountyboard::Application.initialize!
