class ProgramMissionInitializationsController < ApplicationController
  require 'net/http'

  def new
    @mission = Mission.find(params[:mission_id])
    @program = Program.for_mission_for_user(@mission, current_user)
    if @program.nil?
      @program = Program.new(:user_id=>current_user.id, :mission_id=>@mission.id, :source_code=>@mission.source_code)
      if @program.save
        redirect_to @program, notice: 'Program was successfully created.'
      else
        redirect_to @mission
      end
    else
      redirect_to @program
    end
  end
end
