class ChaptersController < ApplicationController
  authorize_actions_for Chapter
  before_action :set_chapter, only: [:show, :edit, :update, :destroy, :remove_mission]
  before_action :set_course, only: [:show, :edit, :update, :destroy, :remove_mission]
  before_filter :authenticate_user!, except: [:show]

  def index
    @title = "Chapitres"
    @from_course = false
    @chapters = Chapter.visible_for(current_user)
  end

  def show
    @title = "Chapitre : #{@chapter.title}"
  end

  def new
    @title = "Créer un chapitre"
    @chapter = Chapter.new
    @from_course = false
    render :new
  end

  def add_chapter
      @title = "Chapitres"
      @chapters = []
      @course = Course.find_by(:id => params[:course_id])
      ids_to_exclude = @course.chapters.map(&:id)
      chapters_table = Arel::Table.new(:chapters)
      @chapters = Chapter.where(chapters_table[:id].not_in ids_to_exclude)
      if ! current_user.try(:has_role?, :admin)
        @chapters = @chapters.where(:teacher => current_user)
      end
      @from_course = true
      @add_chapter = true
      @course = Course.find_by(:id => params[:course_id])
      render :index
  end
  authority_actions :add_chapter => "update"
  

  def create
    @chapter = Chapter.new(chapter_params)
    @chapter.teacher = current_user
    if @chapter.save
      redirect_to chapters_path, notice: "Le chapitre a bien été créé."
    else
      @title = "Créer un chapitre"
      render :new
    end
  end

  def edit
    @title = "Modifier le chapitre : #{@chapter.title}"
  end

  def update
    if @chapter.update(chapter_params)
      redirect_to @chapter, notice: "Le chapitre a bien été mis à jour."
    else
      @title = "Modifier le chapitre : #{@chapter.title}"
      render :edit
    end
  end

  def destroy 
    @chapter.destroy
    redirect_to chapters_url, notice: "Le chapitre a bien été supprimé."
  end
  authority_actions :destroy => 'delete'

  private
    def set_chapter
      @chapter = Chapter.find(params[:id])
    end

    def set_course
      if not params[:course_id].nil?
        @course = Course.find(params[:course_id])
        @from_course = true
      else
        @course = nil
        @from_course = false
      end
    end

    def chapter_params
      p = params.require(:chapter).permit(:title, :description, :small_description, :youtube)
      p
    end
end










