class PasswordsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :load_user, only: [:create, :edit, :update]

  def new
    @user = User.new
  end

  def create
    reset_password_token = SecureRandom.urlsafe_base64 nil, false
    @user.update_attributes reset_password_token: reset_password_token
    PasswordMailer.send_password_email(@user).deliver
  end

  def edit
    unless @user.reset_password_token &&
      @user.reset_password_token == user_params[:reset_password_token]
      flash[:danger] = "失敗した。"
      redirect_to root_url
    end
  end

  def update
    if @user.update_password user_params
      flash[:success] = "成功しました。"
      redirect_to new_user_session_path
    else
      flash[:danger] = "失敗した。"
      redirect_to :back
    end
  end

  private
  def user_params
    params.require(:user).permit :email, :password, :password_confirmation,
      :reset_password_token
  end

  def load_user
    @user = User.find_by email: user_params[:email]
    unless @user
      flash[:danger] = "ユーザーは存在じゃない"
      redirect_to root_path
    end
  end
end
