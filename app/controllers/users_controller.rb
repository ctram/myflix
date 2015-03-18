class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
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
