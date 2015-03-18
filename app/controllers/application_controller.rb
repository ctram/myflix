class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :logged_in?, :current_user # Give views access to these application controller methods.

  def require_user
    if !logged_in?
      flash[:error] = "You must be logged in to do that."
      redirect_to front_path
    end
  end

  # Returns a user object or nil.
  def current_user
    if logged_in?
      User.find(session[:user_id])
    end
  end

  # Checks whether the user is logged into the app. Returns a bool.
  def logged_in?
    session[:user_id] ? true : false
  end

  def log_in(user)
    session[:user_id] = user.id
  end
end
