class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  after_filter :store_location

  def store_location
    if (!request.fullpath.match("/auth.*") && !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || user_path(resource)
  end

  def current_or_null_user
    if current_user == nil
      User.new
    else
      current_user
    end
  end

  protected
  def configure_permitted_parameters
    user_attr_permitted = [:firstname, :lastname]
    devise_parameter_sanitizer.for(:sign_up) << user_attr_permitted
    devise_parameter_sanitizer.for(:account_update) << user_attr_permitted
  end
end
