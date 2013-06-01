module SessionsHelper

  def signIn(user)
    user.save
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
    if cookies[:rememberToken]
      @current_user ||= User.find_by_rememberToken(cookies[:rememberToken])
    else
      @current_user = nil
    end
  end

end

