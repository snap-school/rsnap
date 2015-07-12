class CourseChapterManifestController < ApplicationController
  before_action :set_manifest, only: [:destroy]

  def destroy 
    authorize_action_for @manifest.course
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
