require 'test_helper'

class FileMissionsControllerTest < ActionController::TestCase
  setup do
    @file_mission = FactoryGirl.create(:file_mission)
  end

  def admin_sign_in
    user = FactoryGirl.create(:admin)
    sign_in user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:file_missions)
  end

  test "should get new" do
    admin_sign_in
    get :new
    assert_response :success
  end

  test "should create file_mission" do
    admin_sign_in
    assert_difference('FileMission.count') do
      post :create, file_mission: { file: @file_mission.file, mission_id: @file_mission.mission_id }
    end

    assert_redirected_to file_mission_path(assigns(:file_mission))
  end

  test "should show file_mission" do
    get :show, id: @file_mission
    assert_response :success
  end

  test "should get edit" do
    admin_sign_in
    get :edit, id: @file_mission
    assert_response :success
  end

  test "should update file_mission" do
    admin_sign_in
    patch :update, id: @file_mission, file_mission: { file: @file_mission.file, mission_id: @file_mission.mission_id }
    assert_redirected_to file_mission_path(assigns(:file_mission))
  end

  test "should destroy file_mission" do
    admin_sign_in
    assert_difference('FileMission.count', -1) do
      delete :destroy, id: @file_mission
    end

    assert_redirected_to file_missions_path
  end
end
