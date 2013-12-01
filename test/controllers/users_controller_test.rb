require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = FactoryGirl.create(:user)
  end

  def user_sign_in
    sign_in @user
  end

  def someone_sign_in
    user = FactoryGirl.create(:user)
    sign_in user
  end

  def admin_sign_in
    user = FactoryGirl.create(:admin)
    sign_in user
  end

  test "admin should get index" do
    admin_sign_in
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "user shouldn't get index" do
    FactoryGirl.create(:user) #second user because if index is only @user, no problem, @user can show itself
    user_sign_in
    get :index
    assert_response :forbidden
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      @user = FactoryGirl.build(:user)
      post :create, user: { email: @user.email, firstname: @user.firstname, lastname: @user.lastname, password: @user.password, password_confirmation: @user.password_confirmation }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "user should show user" do
    user_sign_in
    get :show, id: @user
    assert_response :success
  end

  test "user shouldn't show someone else" do
    someone_sign_in
    get :show, id: @user
    assert_response :forbidden
  end

  test "nouser shouldn't show user" do
    get :show, id: @user
    assert_redirected_to controller: "devise/sessions", action: "new"
  end

  test "user should get edit" do
    user_sign_in
    get :edit, id: @user
    assert_response :success
  end

  test "nouser shouldn't get edit" do
    get :edit, id: @user
    assert_response :forbidden
  end

  test "user shouldn't get edit of someone else" do
    someone_sign_in
    get :edit, id: @user
    assert_response :forbidden
  end

  test "user should update user" do
    user_sign_in
    patch :update, id: @user, user: { email: @user.email, firstname: @user.firstname, lastname: @user.lastname }
    assert_redirected_to user_path(assigns(:user))
  end

  test "nouser shouldn't update user" do
    patch :update, id: @user, user: { email: @user.email, firstname: @user.firstname, lastname: @user.lastname }
    assert_response :forbidden
  end

  test "user shouldn't update someone else" do
    someone_sign_in
    patch :update, id: @user, user: { email: @user.email, firstname: @user.firstname, lastname: @user.lastname }
    assert_response :forbidden
  end

  test "user should destroy user" do
    user_sign_in
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end

  test "nouser shouldn't destroy user" do
    assert_no_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_response :forbidden
  end

  test "user shouldn't destroy someone else" do
    someone_sign_in
    assert_no_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_response :forbidden
  end
end
