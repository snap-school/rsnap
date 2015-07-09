class CourseChapterManifestController < ApplicationController
  authorize_actions_for Course
  before_action :set_manifest, only: [:destroy]

  def destroy 
    Course.find_by(:id=>@manifest.course_id).remove_chapter(Chapter.find_by(:id=>@manifest.chapter_id))
    course_id = @manifest.course_id
    @manifest.delete
    redirect_to course_chapters_path(course_id), notice: "Le chapitre a bien été retiré du cours."
  end
  
  private
    def set_manifest
      @manifest = CourseChapterManifest.find_by(:id => params[:id])
    end

end
