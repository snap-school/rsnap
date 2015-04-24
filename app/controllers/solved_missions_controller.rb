class SolvedMissionsController < ApplicationController
  before_action :set_solved_mission, only: [:destroy]

  def create
    @solved_mission = SolvedMission.new(solved_mission_params)
    if (SolvedMission.where(:mission_id=>@solved_mission.mission_id, :user_id=>@solved_mission.user_id).count == 0)
      @solved_mission.save
    end
    render nothing: true
  end

  def destroy
    @solved_mission.destroy
    redirect_to programs_path
  end
  
  private
    def set_solved_mission
      p = params.permit(:id)
      @solved_mission = SolvedMission.find_by_id(p[:id])
    end

    def solved_mission_params
      pp = params.require(:program).permit(:id)
      p = {}
      puts pp
      prog = Program.find_by_id(pp[:id])
      p[:mission_id] = prog.mission_id
      p[:user_id] = prog.user_id
      p
    end
end
