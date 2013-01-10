class SessionsController < ApplicationController

	def create
		
		auth_info = request.env['omniauth.auth']

		if not auth_info.uid
			auth_failure(auth_info, "invalid credentials")
			return
		end

		user = User.find_by_email(auth_info.uid)
		if not user
			# if this user has never visited before, create a
			# user entry for them
			user = User.new(email: auth_info.uid)
			if not user.save
				auth_failure(auth_info, "this appears to be your first visit to our site, but our database rejected your account (#{user.errors.full_messages})")
				return
			end
		end

		auth_success(auth_info)
		render :template => 'board/index'
	end

	private

		def auth_failure(auth_info, message)
			flash.now[:error] = "Sign-in failed: #{message}"
		end

		def auth_success(auth_info)
			flash.now[:notice] = "You've successfully signed in as \"#{auth_info.uid.to_s}\" using the \"#{auth_info.provider.to_s}\" authentication provider.<br><br>Full user info from the provider:<br>#{auth_info}"
		end
end
