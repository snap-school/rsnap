class CourseDesinscriptionController < ApplicationController
  before_action :set_course, only: [:destroy]
  before_filter :authenticate_user!

  def index
    @title = "Se désinscrire d'un cours"
    @courses = current_user.courses
  end

  def destroy
  	return unless current_user.try(:has_role?,:student)
  	current_user.courses.delete(@course)
  	redirect_to courses_path
  end

  private 
    def set_course
      @course = Course.find_by(:id => params[:id])
    end
end
