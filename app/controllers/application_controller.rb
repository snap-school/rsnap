class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  protected

  def configure_permitted_parameters
    user_attr_permitted = [:firstname, :lastname]
    devise_parameter_sanitizer.for(:sign_up) << user_attr_permitted
    devise_parameter_sanitizer.for(:account_update) << user_attr_permitted
  end
end
