class SessionsController < ApplicationController

	def create
		
		auth_info = request.env['omniauth.auth']
		if not auth_info
			auth_failure
		else
			render :text => "You've successfully signed in as \"#{auth_info['uid']}\" using the \"#{auth_info['provider']}\" authentication provider.<br><br>Full user info from the provider:<br>#{auth_info}"
		end

		#@user = User.find_or_create_from_auth_hash(auth_hash)
		#self.current_user = @user
		#redirect_to '/'
	end

	def auth_failure
		render :text => 'Sign-in failed.'
	end
end
