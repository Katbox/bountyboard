# Load the rails application
require File.expand_path('../application', __FILE__)

# Adding in our custom time formatting

Time::DATE_FORMATS[:created_on] = "Created on %B %d %Y"
Time::DATE_FORMATS[:accepted_on] = "%B %d %Y"

# Initialize the rails application
Bountyboard::Application.initialize!
