require 'test_helper'

class ProgramTest < ActiveSupport::TestCase
  test "impossible to create 2 program for the same user and same mission" do
    p1 = FactoryGirl.create(:program)
    assert_raises ActiveRecord::RecordInvalid do
      FactoryGirl.create(:program, :mission_id=>p1.mission_id, :user_id=>p1.mission_id)
    end
  end
end
