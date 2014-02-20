class SortMissionsController < ApplicationController
  authorize_actions_for Mission
  before_filter :authenticate_user!

  def update
    @mission = Mission.find(params[:id])
    @mission.update(mission_params)
    render nothing: true # action called via ajax
  end

  private
    def mission_params
      params.require(:thing).permit(:mission_order_position)
    end
end

