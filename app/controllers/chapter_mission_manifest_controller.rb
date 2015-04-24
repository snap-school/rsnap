class ChapterMissionManifestController < ApplicationController
  authorize_actions_for Chapter
  before_action :set_manifest, only: [:destroy]

  def destroy 
    Chapter.find_by(:id=>@manifest.chapter_id).remove_mission(Mission.find_by(:id=>@manifest.mission_id))
    chapter_id = @manifest.chapter_id
    @manifest.delete
    redirect_to chapter_missions_path(chapter_id), notice: "La mission a bien été retirée du chapitre."
  end
  
  private
    def set_manifest
      @manifest = ChapterMissionManifest.find_by(:id => params[:id])
    end

end
