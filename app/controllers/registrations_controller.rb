class RegistrationsController < Devise::RegistrationsController
  def update
    if params[:user][:id]
      @user = User.find(params[:user][:id])
    else
      @user = current_user
    end

    successfully_updated = if needs_password?(@user, params)
      @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
    else
      # remove the virtual current_password attribute update_without_password
      params[:user].delete(:current_password)
      @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
    end

    if successfully_updated
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
end
