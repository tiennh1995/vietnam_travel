class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :layout_by_resource
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_filter :mailer_set_url_options

  def load_data_static
    if user_signed_in?
      @followings = current_user.just_followed
        .limit Settings.load_more_user_size
      @know_users = current_user.know_users.limit Settings.load_more_user_size
      @popular_images = Image.popular_images
        .limit Settings.load_more_image_size
    end
  end

  protected
  def mailer_set_url_options
    ActionMailer::Base.default_url_options = {host: request.host_with_port}
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit :email,
      :full_name, :password, :password_confirmation, :sex, :avatar, :cover}
  end

  private
  def layout_by_resource
    if devise_controller?
      "application"
    end
  end
end
