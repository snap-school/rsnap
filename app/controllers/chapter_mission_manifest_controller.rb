class ChapterMissionManifestController < ApplicationController
  authorize_actions_for Chapter
  before_action :set_manifest, only: [:destroy]

  def create
    chapter = Chapter.find_by(:id => params[:chapter_id])
    mission = Mission.find_by(:id => params[:mission_id])
    if not chapter.nil? and not mission.nil?
      chapter.add_mission(mission)
      redirect_to "/chapter_missions/#{chapter.id}", notice: "La mission a bien été ajoutée au chapitre."
    elsif not chapter.nil?
      redirect_to add_chapter_missions_path(chapter)
    else
      redirect_to chapters_path
    end
  end

  def destroy 
    Chapter.find_by(:id=>@manifest.chapter_id).remove_mission(Mission.find_by(:id=>@manifest.mission_id))
    chapter_id = @manifest.chapter_id
    @manifest.delete
    redirect_to "/chapter_missions/#{chapter_id}", notice: "La mission a bien été retirée du chapitre."
  end
  
  private
    def set_manifest
      @manifest = ChapterMissionManifest.find_by(:id => params[:id])
    end
end
