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
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :resume, :skills, :experience, :education])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :resume, :skills, :experience, :education])
  end
end
