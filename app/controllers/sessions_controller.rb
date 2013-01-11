class SessionsController < ApplicationController

	def create
		
		auth_info = request.env['omniauth.auth']

		if not auth_info.uid
			auth_failure(auth_info, "invalid credentials")
			return
		end

		user = User.find(:conditions => ["lower(email)=?", auth_info.uid.downcase])
		if not user
			# if this user has never visited before, create a
			# user entry for them
			user = User.new(email: auth_info.uid)
			if not user.save
				auth_failure(auth_info, "this appears to be your first visit to our site, but our database rejected your account (#{user.errors.full_messages})")
				return
			end
		end

		signIn(user)
		render :template => 'board/index'
	end

	private

		def auth_failure(auth_info, message)
			flash.now[:error] = "Sign-in failed: #{message}"
		end

end

