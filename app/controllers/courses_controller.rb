class CoursesController < ApplicationController
  authorize_actions_for Course
  before_action :set_course, only: [:show, :edit, :update, :destroy, :remove_chapter]
  before_filter :authenticate_user!, :except=>[:index, :show]

  def index
    if user_signed_in?
      @title = "Mes cours"
      @courses = Course.visible_for(current_user)
    else
      @title = "Les cours"
      @courses = Course.all
    end
  end

  def show
      @title = "Cours : #{@course.title}"
  end

  def new
    @title = "Créer un cours"
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    @course.teacher = current_user
    if @course.save
      redirect_to courses_path, notice: "Le cours a bien été créé."
    else
      @title = "Créer un cours"
      render :new
    end
  end

  def edit
    @title = "Modifier le cours : #{@course.title}"
  end

  def update
    if @course.update(course_params)
      redirect_to @course, notice: "Le cours a bien été mis à jour."
    else
      @title = "Modifier le cours : #{@course.title}"
      render :edit
    end
  end

  def destroy 
    @course.destroy
    redirect_to courses_url, notice: "Le cours a bien été supprimé."
  end

  private
    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      p = params.require(:course).permit(:title, :description)
      p
    end
end
