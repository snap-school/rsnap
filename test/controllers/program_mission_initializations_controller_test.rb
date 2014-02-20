require 'test_helper'

class InitializationProgramMissionsControllerTest < ActionController::TestCase
  setup do
    @program = FactoryGirl.create(:program)
  end

  def user_sign_in
    sign_in @program.user
  end

  test "user should get new" do
    user_sign_in
    get :new, mission_id: @program.mission_id
    assert_redirected_to @program
  end

  test "nouser shouldn't get new" do
    get :new, mission_id: @program.mission_id
    assert_redirected_to controller: "devise/sessions", action: "new"
  end
end
