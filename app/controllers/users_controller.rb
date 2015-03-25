class UsersController < ApplicationController
  def new
    redirect_to videos_path if logged_in?
    @user = User.new
  end

  def create
    redirect_to videos_path if logged_in?
    @user = User.new(params_user)
    if @user.save
      flash[:notice] = 'Successfully registered!'
      log_in(@user)
      redirect_to home_path
    else
      render :new
    end
  end

  private

  def params_user
    params.require(:user).permit(:name_first, :name_last, :email, :password, :password_confirmation)
  end
end
