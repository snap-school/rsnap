class MissionsController < ApplicationController
  authorize_actions_for Mission
  before_action :set_mission, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except=>[:index, :show]

  def index
    @title = "Missions"
    @missions = []
    @from_chapter = false
    if params[:id].nil?
      @missions = Mission.visible_for(current_user)
    else
      Mission.all.each do |mission|
        if ChapterMissionManifest.find_by(:chapter_id=>params[:id], :mission_id=>mission.id).nil?
          @missions.append(mission)
        end
      end
      @from_chapter = true
      @chapter_from = Chapter.find_by(:id=>params[:id])
      @disabled_from = @chapter_from.get_disabled_from(current_user)
    end
  end

  def show
    if params[:modal]
      render :modal_show, :layout=>false
    else
      @title = "Mission : #{@mission.title}"
    end
  end

  def new
    @title = "Créer une mission"
    @mission = Mission.new
  end

  def create
    @mission = Mission.new(mission_params)

    if @mission.save
      @mission.update_attribute :mission_order_position, :last
      redirect_to mission_program_path(@mission), notice: "La mission a bien été créée."
    else
      @title = "Créer une mission"
      render :new
    end
  end

  def edit
    @title = "Modifier la mission : #{@mission.title}"
  end

  def update
    if @mission.update(mission_params)
      redirect_to @mission, notice: "La mission a bien été mise à jour."
    else
      @title = "Modifier la mission : #{@mission.title}"
      render :edit
    end
  end

  def destroy
    @mission.destroy
    redirect_to missions_url, notice: "La mission a bien été supprimée."
  end

  private
    def set_mission
      @mission = Mission.find(params[:id])
    end

    def mission_params
      p = params.require(:mission).permit(:title, :description, :small_description, :source_code, :youtube)
      template = ""
      project_name = "Unitled"
      file_path = "#{Rails.root}/public/default_mission.xml"
      if not params[:source_code].eql?("")
        mission = Mission.find_by(:id=>(params[:source_code]).to_i)
        project_name = mission.title
      end

      File.open(file_path, "r") do |infile|
        while(line = infile.gets) do
          template << line.gsub(project_name, p[:title])
        end
      end
      name = [p[:title],".xml"]
      file = Tempfile.new(name, "#{Rails.root}/tmp")
      file.write(template)
      file.rewind
      p[:source_code] = file
      p
    end
end
