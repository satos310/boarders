class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_admin!, if: :admin_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:name, :email, :encrypted_password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  private

  def admin_controller?
    controller_path.start_with?('admin/')
  end

  def authenticate_admin!
    if controller_path.start_with?('admin/') && !admin_signed_in?
      redirect_to new_admin_session_path
    elsif !devise_controller? && !user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
