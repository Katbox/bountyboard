module SessionsHelper

	def signIn(user)
		cookies.permanent[:rememberToken] = user.rememberToken
		self.currentUser = user
	end

	def signed_in?
		!currentUser.nil?
	end

	def currentUser=(user)
		@currentUser = user
	end

	def currentUser
		if cookies[:remember_token]
			@current_user ||= User.find_by_rememberToken(cookies[:remember_token])
		else
			@current_user = nil
		end
	end

end

