class MissionsController < ApplicationController
  authorize_actions_for Mission
  before_action :set_mission, only: [:show, :edit, :update, :destroy]
  before_action :set_chapter_and_course, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except=>[:show]

  def index
    @title = "Missions"
    @from_chapter = false
    @missions = Mission.visible_for(current_user)
  end

  def show
    if params[:modal]
      render :modal_show, :layout=>false
    elsif params[:goal]
      @course = Course.find_by_id(session[:current_course_id])
      render :modal_goal, :layout=>false
    else
      @title = "Mission : #{@mission.title}"
    end
  end

  def new
    @title = "Missions"
    @missions = []
    @from_chapter = false
    if params[:chapter_id].nil?
      @title = "Créer une mission"
      @mission = Mission.new
      render :new
    else
      Mission.find_each do |mission|
        if ChapterMissionManifest.find_by(:chapter_id=>params[:chapter_id], :mission_id=>mission.id).nil?
          @missions.append(mission)
        end
      end
      @from_chapter = true
      @add_mission = true
      @chapter = Chapter.find_by(:id=>params[:chapter_id])
      render :index
    end
  end

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
        @chapter = Chapter.find_by(:id=>params[:chapter_id])
        if params[:course_id].nil?
          @from_course = false
        else
          @from_course = true
          @course = Course.find_by(:id=>params[:course_id])
        end
      end
    end


    def mission_params
      p = params.require(:mission).permit(:title, :description, :small_description, :source_code, :youtube, :needs_check)

      template = ""
      project_name = "Unitled"
      file_path = "#{Rails.root}/public/default_mission.xml"

      if not params[:source_code].eql?("")
        mission = Mission.find_by(:id=>(params[:source_code]).to_i)
        project_name = mission.title
        file_path = "#{Rails.root}/public#{mission.source_code.url.split('/')[0..-2].join('/')}/#{mission.source_code_file_name}"
      end

      template_file = File.open(file_path, "r") 
      line = template_file.gets
      while(line) do
        template << line.gsub(project_name, p[:title])
        line = template_file.gets
      end
      
      name = [p[:title],".xml"]
      file = Tempfile.new(name, "#{Rails.root}/tmp")
      file.write(template)
      file.rewind
      p[:source_code] = file
      p
    end
end
