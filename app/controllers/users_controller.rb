class UsersController < ApplicationController
  def new
    redirect_to videos_path if logged_in?
    @user = User.new
  end

  def create

    if logged_in?
      redirect_to videos_path
    else
      @user = User.new(params_user)
      if @user.save
        handle_invitation
        AppMailer.send_welcome_email(@user).deliver
        flash[:notice] = 'Successfully registered!'
        log_in(@user)
        redirect_to home_path
      else
        render :new
      end
    end
  end

  def show
    if logged_in?
      @user = User.find(params[:id])
    else
      redirect_to sign_in_path
    end
  end

  def new_with_invitation_token
    invitation = Invitation.where(token: params[:token]).first
    if invitation
      @user = User.new(email: invitation.recipient_email)
      @invitation_token = invitation.token
      render :new
    else
      redirect_to expired_token_path
    end
  end

  private

  def handle_invitation
    if params[:invitation_token].present?
      invitation = Invitation.where(token: params[:invitation_token]).first
      @user.follow(invitation.inviter)
      invitation.inviter.follow(@user)
      invitation.update_column(:token, nil)
    end
  end


  def params_user
    params.require(:user).permit(:name_first, :name_last, :email, :password, :password_confirmation)
  end
end
