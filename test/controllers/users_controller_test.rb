require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = FactoryGirl.create(:user)
  end

  def user_sign_in
    sign_in @user
  end

  test "should get index" do
    user = FactoryGirl.create(:admin)
    sign_in user
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
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

  test "should show user" do
    user_sign_in
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    user_sign_in
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    user_sign_in
    patch :update, id: @user, user: { email: @user.email, firstname: @user.firstname, lastname: @user.lastname }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    user_sign_in
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
