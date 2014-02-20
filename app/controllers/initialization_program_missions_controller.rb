class InitializationProgramMissionsController < ApplicationController
  authorize_actions_for Program
  before_filter :authenticate_user!

  def new
    @mission = Mission.find(params[:mission_id])
    @program = Program.for_mission_for_user(@mission, current_user)
    unless @program
      initialize_new_program
    else
      authorize_action_for @program
      redirect_to @program
    end
  end

  private
  def initialize_new_program
    @program = Program.new( :user_id=>current_user.id,
                            :mission_id=>@mission.id,
                            :source_code=>@mission.source_code)
    authorize_action_for @program
    if @program.save
      redirect_to @program, notice: 'Program was successfully created.'
    else
      redirect_to @mission
    end
  end
end
