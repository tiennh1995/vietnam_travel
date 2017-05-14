class PasswordMailer < ApplicationMailer
  def send_password_email user
    @user = user
    mail to: @user.email, subject: "これはパスワードをリセットするメールです。"
  end
end
