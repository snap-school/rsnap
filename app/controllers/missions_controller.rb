class MissionsController < ApplicationController
  before_action :set_mission, only: [:show, :edit, :update, :destroy]

  # GET /missions
  def index
    @missions = Mission.all
  end

  # GET /missions/1
  def show
  end

  # GET /missions/new
  def new
    @mission = Mission.new
  end

  # GET /missions/1/edit
  def edit
  end

  # POST /missions
  def create
    @mission = Mission.new(mission_params)

    if @mission.save
      redirect_to @mission, notice: 'Mission was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /missions/1
  def update
    if @mission.update(mission_params)
      redirect_to @mission, notice: 'Mission was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /missions/1
  def destroy
    @mission.destroy
    redirect_to missions_url, notice: 'Mission was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mission
      @mission = Mission.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def mission_params
      params.require(:mission).permit(:title, :description, :source_code)
    end
end
