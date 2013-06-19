# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController

  include SessionsHelper

  def create

    auth_info = request.env['omniauth.auth']

    if not auth_info.uid
      handle_auth_failure("invalid credentials")
      return
    end

    user = User.find(:first, :conditions => ["lower(email)=?", auth_info.uid.downcase])
    if not user
      # if this user has never visited before, create a
      # user entry for them
      user = User.new(email: auth_info.uid)
      if not user.save
        handle_auth_failure(auth_info, "this appears to be your first visit to our site, but our database rejected your account (#{user.errors.full_messages})")
        return
      end
    end

    signIn(user)
    redirect_to root_path, :status => 303
  end

  # Omniauth calls this method when a user's sign-in process fails while Omniauth is handling the user
  def auth_failure()
    # make the OmniAuth message slightly more user-friendly by replacing underscores with spaces
    handle_auth_failure(params[:message].gsub(/_/, ' '))
  end

  def destroy()
    # stub
  end

  private

    # this method handles failed sign-in by displaying to the user why their sign-in process failed
    def handle_auth_failure(message)
      flash[:error] = "Sign-in failed: #{message}"
      redirect_to root_path, :status => 303
    end

end

