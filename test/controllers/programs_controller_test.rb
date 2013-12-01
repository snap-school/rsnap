require 'test_helper'

class ProgramsControllerTest < ActionController::TestCase
  setup do
    @program = FactoryGirl.create(:program)
    sign_in @program.user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:programs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create program" do
    assert_difference('Program.count') do
      post :create, program: {:user_id=>@program.user_id, :mission_id=>@program.mission_id, :source_code=>@program.source_code}
    end

    assert_redirected_to program_path(assigns(:program))
  end

  test "should show program" do
    get :show, id: @program
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @program
    assert_response :success
  end

  test "should update program" do
    patch :update, id: @program, program: {:user_id=>@program.user_id, :mission_id=>@program.mission_id, :source_code=>@program.source_code}
    assert_redirected_to program_path(assigns(:program))
  end

  test "should destroy program" do
    user = FactoryGirl.create(:admin)
    sign_in user
    assert_difference('Program.count', -1) do
      delete :destroy, id: @program
    end

    assert_redirected_to programs_path
  end
end
