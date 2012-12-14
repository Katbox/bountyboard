class SessionsController < ApplicationController

	def create
		
		render :text => "authorization hash:<br>#{auth_hash}"

		#@user = User.find_or_create_from_auth_hash(auth_hash)
		#self.current_user = @user
		#redirect_to '/'
	end

	def auth_failure
	end

	protected

	def auth_hash
		request.env['omniauth.auth']
	end
end
