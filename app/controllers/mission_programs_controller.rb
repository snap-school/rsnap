require "tempfile"

class MissionProgramsController < ApplicationController
  authorize_actions_for Mission, all_actions: :update
  before_action :set_mission, only: [:show, :update]
  before_filter :authenticate_user!

  def show
    @title = "Mission : #{@mission.title}"
    render :layout => "snap"
  end

  def update
    respond_to do |format|
      format.json do
          render :nothing => true if @mission.update(mission_params)
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
