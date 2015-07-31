class InitializationProgramMissionsController < ApplicationController
  authorize_actions_for Program
  before_filter :authenticate_user!

  def new
    @mission = Mission.find(params[:mission_id])
    @program = Program.for_mission_for_user(@mission, current_user)
    session[:current_course_id] = params[:course_id]
    set_program
  end

  private
  def set_program
    User.create_with(last_name: 'Johansson').find_or_create_by(first_name: 'Scarlett')
    @program = Program.create_with(source_code: @mission.source_code).find_or_create_by(user_id:  current_user.id,
                           mission_id:  @mission.id)
    authorize_action_for @program
    if @program.save
      redirect_to @program, notice: "Le programme à bien été créé"
    else
      redirect_to @mission
    end
  end
end
