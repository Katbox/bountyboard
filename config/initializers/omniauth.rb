require 'omniauth-browserid'
require 'omniauth-deviantart'

# send log messages from our authentication system to the Rails log
OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
	provider :browser_id
	provider :deviantart, Rails.configuration.deviantart_app_id, Rails.configuration.deviantart_secret
end

