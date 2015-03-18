class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # TODO: check that the user trying to log in is an existing user in the db. If not, show error message. If so, create a new session ID.
    user = User.find_by(email: params[:user][:email])
    binding.pry
    if user
      session[:id] = user.id
      flash[:notice] = "You've successfully signed in!"
      redirect_to videos_path
      binding.pry
    else
      flash[:error] = "Sorry, there is something wrong with your username or password."
      @user = User.new
      render :new
    end
  end

  def destroy
    session[:id] = nil
    flash[:notice] = 'You are now signed off.'
    redirect_to videos_path
  end

end
