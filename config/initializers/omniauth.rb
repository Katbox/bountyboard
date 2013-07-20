# -*- encoding : utf-8 -*-
require 'omniauth-browserid'
require 'omniauth-deviantart'

# send log messages from our authentication system to the Rails log
OmniAuth.config.logger = Rails.logger

# uncomment this line to test logging in as an artist, or another user
# OmniAuth.config.test_mode = true
# OmniAuth.config.mock_auth[:browser_id] = OmniAuth::AuthHash.new({
#   :provider => 'browserid',
#   :uid => 'lionheartstudio@gmail.com'
# })

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :browser_id
  provider :deviantart, Rails.configuration.deviantart_app_id, Rails.configuration.deviantart_secret
end

