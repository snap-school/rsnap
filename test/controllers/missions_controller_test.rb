require 'test_helper'

class MissionsControllerTest < ActionController::TestCase
  setup do
    @mission = FactoryGirl.create(:mission)
  end

  def admin_sign_in
    user = FactoryGirl.create(:admin)
    sign_in user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:missions)
  end

  test "should get new" do
    admin_sign_in
    get :new
    assert_response :success
  end

  test "should create mission" do
    admin_sign_in
    assert_difference('Mission.count') do
      post :create, mission: { description: @mission.description, source_code: @mission.source_code, title: @mission.title }
    end

    assert_redirected_to mission_path(assigns(:mission))
  end

  test "should show mission" do
    get :show, id: @mission
    assert_response :success
  end

  test "should get edit" do
    admin_sign_in
    get :edit, id: @mission
    assert_response :success
  end

  test "should update mission" do
    admin_sign_in
    patch :update, id: @mission, mission: { description: @mission.description, source_code: @mission.source_code, title: @mission.title }
    assert_redirected_to mission_path(assigns(:mission))
  end

  test "should destroy mission" do
    admin_sign_in
    assert_difference('Mission.count', -1) do
      delete :destroy, id: @mission
    end

    assert_redirected_to missions_path
  end
end
