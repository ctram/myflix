class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if user = User.find_by(email: params[:user][:email])
      session[:id] = user.id
      flash[:notice] = "You've successfully signed in!"
      redirect_to videos_path
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
