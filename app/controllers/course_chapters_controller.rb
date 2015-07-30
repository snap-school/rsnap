class CourseChaptersController < ApplicationController
  authorize_actions_for Course
  before_action :set_course_chapters, only: [:index]

  before_filter :authenticate_user!, :except => [:index]

  def index
    @title = "Cours : #{@course.title}"
    @from_course = true
  end

  def create
    course = Course.find_by(:id => params[:course_id])
    chapter = Chapter.find_by(:id => params[:chapter_id])
    if not course.nil? and not chapter.nil?
      course.add_chapter(chapter)
      redirect_to course_chapters_path(course), notice: "Le chapitre a bien été ajouté au cours."
    else
      redirect_to session[:previous_url]
    end
  end

  private
    def set_course_chapters
      @course = Course.find_by_id(params[:course_id])
      manifests = CourseChapterManifest.where(:course_id => @course.id).order("order" => :asc)
      @chapters = []
      manifests.each do |manif|
        @chapters.append(Chapter.find_by_id(manif.chapter_id))
      end
    end
end
