require 'test_helper'

class MissionsControllerTest < ActionController::TestCase
  setup do
    @mission = FactoryGirl.create(:mission)
  end

  def admin_sign_in
    user = FactoryGirl.create(:admin)
    sign_in user
  end

  def user_sign_in
    user = FactoryGirl.create(:user)
    sign_in user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:missions)
  end

  test "admin should get new" do
    admin_sign_in
    get :new
    assert_response :success
  end

  test "user shouldn't get new" do
    user_sign_in
    get :new
    assert_response :forbidden
  end

  test "admin should create mission" do
    admin_sign_in
    assert_difference('Mission.count') do
      post :create, mission: { description: @mission.description, source_code: @mission.source_code, title: @mission.title }
    end

    assert_redirected_to mission_path(assigns(:mission))
  end

  test "user shouldn't create mission" do
    user_sign_in
    assert_no_difference('Mission.count') do
      post :create, mission: { description: @mission.description, source_code: @mission.source_code, title: @mission.title }
    end
    assert_response :forbidden
  end

  test "should show mission" do
    get :show, id: @mission
    assert_response :success
  end

  test "admin should get edit" do
    admin_sign_in
    get :edit, id: @mission
    assert_response :success
  end

  test "user shouldn't get edit" do
    user_sign_in
    get :edit, id: @mission
    assert_response :forbidden
  end

  test "admin should update mission" do
    admin_sign_in
    patch :update, id: @mission, mission: { description: @mission.description, source_code: @mission.source_code, title: @mission.title }
    assert_redirected_to mission_path(assigns(:mission))
  end

  test "user shouldn't update mission" do
    user_sign_in
    patch :update, id: @mission, mission: { description: @mission.description, source_code: @mission.source_code, title: @mission.title }
    assert_response :forbidden
  end

  test "admin should destroy mission" do
    admin_sign_in
    assert_difference('Mission.count', -1) do
      delete :destroy, id: @mission
    end

    assert_redirected_to missions_path
  end

  test "user should destroy mission" do
    user_sign_in
    assert_no_difference('Mission.count', -1) do
      delete :destroy, id: @mission
    end

    assert_response :forbidden
  end
end
