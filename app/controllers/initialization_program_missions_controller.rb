class InitializationProgramMissionsController < ApplicationController
  authorize_actions_for Program
  before_filter :authenticate_user!

  def new
    @mission = Mission.find(params[:mission_id])
    session[:current_course_id] = params[:course_id]
    @program = Program.create_with(source_code: @mission.source_code).find_or_create_by(user_id:  current_user.id,
                           mission_id:  @mission.id)
    authorize_action_for @program
    @program.save! if @program.new_record?
    redirect_to @program, notice: "Le programme à bien été créé"
  end

end
