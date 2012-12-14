require 'omniauth-browserid'

# send log messages from our authentication system to the Rails log
OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
	provider :browser_id
end

