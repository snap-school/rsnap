class FileMissionsController < ApplicationController
  authorize_actions_for FileMission
  before_action :set_file_mission, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]

  def index
    @title = "Fichiers de mission"
    @file_missions = FileMission.all
  end

  def show
    @title = "Fichiers de missions"
  end

  def new
    @title = "Créer un fichier de mission"
    @file_mission = FileMission.new
  end

  def edit
    @title = "Modifier un fichier de mission"
  end

  def create
    @file_mission = FileMission.new(file_mission_params)

    respond_to do |format|
      format.html do
        if @file_mission.save
          redirect_to @file_mission, notice: "Un fichier de mission a bien été crée."
        else
          @title = "Créer un fichier de mission"
          render :new
        end
      end
      format.json do
        if @file_mission.save
          render :show
        else
          render :json => { :errors => @file_mission.errors.full_messages }
        end
      end
    end
  end

  def update
    if @file_mission.update(file_mission_params)
      redirect_to @file_mission, notice: "Un fichier de mission à bien été mis à jour."
    else
      @title = "Modifier un fichier de mission"
      render :edit
    end
  end

  def destroy
    @file_mission.destroy
    redirect_to file_missions_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_file_mission
      @file_mission = FileMission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def file_mission_params
      if params[:file_mission]
        params.require(:file_mission).permit(:mission_id, :file)
      else
        params.permit(:file)
      end
    end
end
