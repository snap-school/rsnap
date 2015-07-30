class MissionsController < ApplicationController
  authorize_actions_for Mission
  before_action :set_mission, only: [:show, :edit, :update, :destroy]
  before_action :set_chapter_and_course, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except:  [:show]

  def index
    @title = "Missions"
    @from_chapter = false
    @missions = Mission.visible_for(current_user)
  end

  def show
    if params[:modal]
      render :modal_show, layout:  false
    elsif params[:goal]
      @course = Course.find_by_id(session[:current_course_id])
      render :modal_goal, layout:  false
    else
      @title = "Mission : #{@mission.title}"
    end
  end

  def new
    @from_chapter = false
    @title = "Créer une mission"
    @mission = Mission.new
    render :new
  end

  def add_mission
    @title = "Missions"
    @missions = []
    @chapter = Chapter.find_by(id:  params[:chapter_id])
    ids_to_exclude = @chapter.missions.map(&:id)
    missions_table = Arel::Table.new(:missions)
    @missions = Mission.where(missions_table[:id].not_in ids_to_exclude)
    @missions = @missions.where(teacher:  current_user) unless current_user.try(:has_role?, :admin)
    @from_chapter = true
    @add_mission = true
    render :index
  end
  authority_actions add_mission:  "update"

  def create
    @mission = Mission.new(mission_params)
    @mission.teacher = current_user
    if @mission.save
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

    def set_chapter_and_course
      if params[:chapter_id].nil?
        @from_chapter = false
        @from_course = false
      else
        @chapter = Chapter.find_by(id:  params[:chapter_id])
        if params[:course_id].nil?
          @from_course = false
        else
          @from_course = true
          @course = Course.find_by(id:  params[:course_id])
        end
      end
    end

    def mission_params
      p = params.require(:mission).permit(:title, :description, :small_description, :source_code, :youtube, :needs_check)

      project_name = "Untitled"
      file_path = "#{Rails.root}/public/default_mission.xml"

      unless params[:source_code].eql?("")
        mission = Mission.find_by(id:  (params[:source_code]).to_i)
        project_name = mission.title
        file_path = mission.source_code.path
      end

      template = File.read(file_path).gsub(project_name, p[:title])

      file = Tempfile.new([p[:title],".xml"], "#{Rails.root}/tmp")
      file.write(template)
      file.rewind
      p[:source_code] = file
      p
    end
end
