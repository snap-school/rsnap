require 'test_helper'

class ProgramsControllerTest < ActionController::TestCase
  setup do
    @program = FactoryGirl.create(:program)
  end

  def user_sign_in
    sign_in @program.user
  end

  def admin_sign_in
    user = FactoryGirl.create(:admin)
    sign_in user
  end

  test "user should get index" do
    user_sign_in
    get :index
    assert_response :success
    assert_not_nil assigns(:programs)
  end

  test "nouser shouldn't get index" do
    get :index
    assert_redirected_to controller: "devise/sessions", action: "new"
  end

  test "user should get new" do
    user_sign_in
    get :new
    assert_response :success
  end

  test "nouser shouldn't get new" do
    get :new
    assert_redirected_to controller: "devise/sessions", action: "new"
  end

  test "user should create program" do
    user_sign_in
    mission = FactoryGirl.create(:mission)
    assert_difference('Program.count') do
      post :create, program: FactoryGirl.attributes_for(:program, :mission_id => mission.id, :user_id => @program.user.id)
    end

    assert_redirected_to program_path(assigns(:program))
  end

  test "nouser shouldn't create program" do
    assert_no_difference('Program.count') do
      post :create, program: FactoryGirl.attributes_for(:program)
    end

    assert_redirected_to controller: "devise/sessions", action: "new"
  end

  test "user should show program" do
    user_sign_in
    get :show, id: @program
    assert_response :success
  end

  test "nouser shouldn't show program" do
    get :show, id: @program
    assert_response :forbidden
  end

  test "user should get edit" do
    user_sign_in
    get :edit, id: @program
    assert_response :success
  end

  test "nouser shouldn't get edit" do
    get :edit, id: @program
    assert_response :forbidden
  end

  test "user should update program" do
    user_sign_in
    patch :update, id: @program, program: FactoryGirl.attributes_for(:program, :mission_id => @program.mission.id, :user_id => @program.user.id)
    assert_redirected_to program_path(@program)
  end

  test "user shouldn't update program of someone else" do
    user = FactoryGirl.create(:user)
    sign_in user
    patch :update, id: @program, program: FactoryGirl.attributes_for(:program, :mission_id => @program.mission.id, :user_id => @program.user.id)
    assert_response :forbidden
  end

  test "nouser shouldn't update program" do
    patch :update, id: @program, program: FactoryGirl.attributes_for(:program)
    assert_response :forbidden
  end

  test "admin should destroy program" do
    admin_sign_in
    assert_difference('Program.count', -1) do
      delete :destroy, id: @program
    end

    assert_redirected_to programs_path
  end

  test "user shouldn't destroy program" do
    user_sign_in
    assert_no_difference('Program.count', -1) do
      delete :destroy, id: @program
    end

    assert_response :forbidden
  end
end
