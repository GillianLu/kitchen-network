class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_params, only: [:create, :create_admin]
  
  def new_admin
    @admin = User.new
    @admin.role = Role.find_by(role_name: 'admin')
    respond_with @admin, resource_name: :admin
  end

  def create_admin
    @admin = User.new(sign_up_params)
    @admin.role = Role.find_by(role_name: 'admin')
  
    if @admin.save
      set_flash_message! :notice, :signed_up
      sign_up(resource_name, @admin)
      respond_with @admin, location: after_sign_up_path_for(@admin)
    else
      clean_up_passwords @admin
      set_minimum_password_length
      respond_with @admin, action: :new_admin
    end
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    registered_path(resource_id: resource.id)
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   registered_path
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end
  
  private

  def configure_permitted_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :phone_number, :role_id, :password, :password_confirmation])
  end
end
