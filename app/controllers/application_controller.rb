class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :layout_by_resource
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit :email,
      :full_name, :password, :password_confirmation, :sex, :avatar}
  end

  private
  def layout_by_resource
    if devise_controller?
      "application"
    end
  end
end
