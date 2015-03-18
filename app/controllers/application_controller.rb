class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :logged_in?, :current_user # Give views access to these application controller methods.

  # Returns a user object or nil.
  def current_user
    if logged_in?
      User.find(session[:id])
    end
  end

  # Checks whether the user is logged into the app. Returns a bool.
  def logged_in?
    session[:id] ? true : false
  end

  def log_in(user)
    session[:id] = user.id
  end
end
