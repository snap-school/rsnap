class InitializationProgramMissionsController < ApplicationController
  authorize_actions_for Program
  before_filter :authenticate_user!

  def new
    session[:current_course_id] = params[:course_id]
    @program = Program.find_by(user: current_user, mission_id: params[:mission_id])

    if @program.present?
      redirect_to @program
    else
      @mission = Mission.find(params[:mission_id])
      @program = Program.new(source_code: @mission.source_code, user:  current_user, mission:  @mission)
      @program.save!
      authorize_action_for @program
      redirect_to @program, notice: "Le programme à bien été créé"
    end
  end
end
