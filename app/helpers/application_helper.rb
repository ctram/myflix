module ApplicationHelper

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
end
