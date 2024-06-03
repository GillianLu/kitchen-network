class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_users_path
    else
      super
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:photo, :first_name, :last_name, :email, :phone_number, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:photo, :first_name, :last_name, :email, :phone_number, :password, :password_confirmation, :current_password])
  end
end
