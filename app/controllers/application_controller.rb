class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  after_filter :store_location
  before_filter :flash_notice

  def flash_notice
    if current_user
      i = 0
      str = "Les missions suivantes sont corrigées: "
      Program.where(user:  current_user, state:  2).find_each do |p|
        if p.is_corrected?
          str += ((i > 0) ? ", ": "") + "#{p.mission_title}"
          i = i + 1
        end
      end
      flash[:user] = str if i > 0
    end
  end

  def store_location
    if !request.fullpath.match("/auth.*") && !request.xhr? # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    courses_path
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
