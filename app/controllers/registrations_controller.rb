class RegistrationsController < Devise::RegistrationsController
  authorize_actions_for User

  after_filter :new_user

  before_action :set_user, :only => [:update]

  def update
    authorize_action_for @user

    if update_user
      set_flash_message :notice, :updated
      if @user == current_user
        # Sign in the user bypassing validation in case his password changed
        sign_in @user, :bypass => true
      end
      redirect_to @user
    else
      render "devise/registrations/edit"
    end
  end

  private
  # check if we need password to update user data
  def needs_password?(user, params)
    user.email != params[:user][:email] ||
      params[:user][:password].present?
  end

  def new_user
    if resource.persisted? # user is created successfuly
      resource.type = (params[:user][:type] == "0" ? "Student" : "Teacher")
      resource.save!
    end
  end

  def set_user
    if params[:user][:id]
      @user = User.find(params[:user][:id])
    else
      @user = current_user
    end
  end

  def update_user
    if needs_password?(@user, params)
      @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
    else
      # remove the virtual current_password attribute update_without_password
      params[:user].delete(:current_password)
      @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
    end
  end
end
