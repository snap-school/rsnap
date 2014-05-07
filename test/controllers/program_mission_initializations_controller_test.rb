require 'test_helper'

class InitializationProgramMissionsControllerTest < ActionController::TestCase

  setup do
    @mission = FactoryGirl.create(:mission)
  end

  def user_sign_in
    sign_in FactoryGirl.create(:user)
  end

  test "user should get new" do
    user_sign_in
    get :new, mission_id: @mission.id
    assert_response :redirect
  end

  test "nouser shouldn't get new" do
    get :new, mission_id: @mission.id
    assert_redirected_to controller: "devise/sessions", action: "new"
  end
end
