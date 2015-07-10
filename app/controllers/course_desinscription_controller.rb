class CourseDesinscriptionController < ApplicationController
  before_action :set_course, only: [:destroy]

  def index
    @title = "Se désinscrire d'un cours"
    @courses = current_user.courses
  end

  def destroy
  	return unless current_user.is_student?
  	current_user.courses.delete(@course)
  	redirect_to courses_path
  end

  private 
    def set_course
      @course = Course.find_by(:id=>params[:id])
    end
end
