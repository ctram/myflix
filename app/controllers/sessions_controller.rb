class SessionsController < ApplicationController
  before_action :require_user, only: [:destroy]

  def new
    redirect_to videos_path if logged_in?
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:user][:email])
    if user and user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      flash[:notice] = "You've successfully signed in!"
      redirect_to videos_path
    else
      flash[:error] = "Sorry, there is something wrong with your username or password."
      @user = User.new
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You are now signed off.'
    redirect_to front_path
  end

end

# TODO: add authentication of the password on the sign in page.
# TODO: if logged in, user is not able to get to the front page or the sign in page or the register page.
