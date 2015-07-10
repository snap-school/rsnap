class CourseInscriptionController < ApplicationController
  before_action :set_course, only: [:create]

  def index
    @title = "S'inscrire à un cours"
    ids_to_exclude = current_user.courses.map(&:id)
    courses_table = Arel::Table.new(:courses)
    @courses = Course.where(courses_table[:id].not_in ids_to_exclude)
 end

  def create
  	return unless current_user.is_student?
  	current_user.courses.append(@course)
  	redirect_to courses_path
  end

  private 
    def set_course
      @course = Course.find_by(:id=>params[:course_id])
    end
end
