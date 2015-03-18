class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # TODO: check that the user trying to log in is an existing user in the db. If not, show error message. If so, create a new session ID.
    if User.find_by(email: params[:email])

    end
  end

  def destroy
    session[:id] = nil
    flash[:notice] = 'You are now signed off.'
    redirect_to videos_path
  end

end
