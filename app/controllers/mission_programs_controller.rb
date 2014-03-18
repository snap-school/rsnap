require 'tempfile'

class MissionProgramsController < ApplicationController
  authorize_actions_for Mission
  before_action :set_mission, only: [:show, :update]
  before_filter :authenticate_user!

  def show
    @title = "Programme : #{@mission.title}"
    render :layout=>"snap"
  end

  def update
    respond_to do |format|
      format.json do
        if @mission.update(mission_params)
          render "mission/show"
        else
          render :json => { :errors => @mission.errors.full_messages }
        end
      end
    end
  end

  private
    def set_mission
      @mission = Mission.find(params[:id])
    end

    def mission_params
      p = params.require(:program).permit(:source_code)
      if p[:source_code].instance_of?(String)
        name = ["#{@mission.id}-#{@mission.title}", ".xml"]
        file = Tempfile.new(name, "#{Rails.root}/tmp")
        file.write(p[:source_code])
        file.rewind
        p[:source_code] = file
      end
      p
    end
end
