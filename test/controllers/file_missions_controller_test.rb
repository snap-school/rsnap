require 'test_helper'

class FileMissionsControllerTest < ActionController::TestCase
  setup do
    @file_mission = FactoryGirl.create(:file_mission)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:file_missions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create file_mission" do
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
    get :edit, id: @file_mission
    assert_response :success
  end

  test "should update file_mission" do
    patch :update, id: @file_mission, file_mission: { file: @file_mission.file, mission_id: @file_mission.mission_id }
    assert_redirected_to file_mission_path(assigns(:file_mission))
  end

  test "should destroy file_mission" do
    assert_difference('FileMission.count', -1) do
      delete :destroy, id: @file_mission
    end

    assert_redirected_to file_missions_path
  end
end
