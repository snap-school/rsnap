class ChapterMissionsController < ApplicationController
  authorize_actions_for Chapter
  before_action :set_chapter_missions, only: [:index]
  before_filter :authenticate_user!, :except=>[:index]

  def index
    @title = "Chapitre : #{@chapter.title}"
  end

  def create
    chapter = Chapter.find_by(:id => params[:chapter_id])
    mission = Mission.find_by(:id => params[:mission_id])
    if not chapter.nil? and not mission.nil?
      chapter.add_mission(mission)
      redirect_to chapter_missions_path(chapter), notice: "La mission a bien été ajoutée au chapitre."
    elsif not chapter.nil?
      redirect_to add_chapter_missions_path(chapter)
    else
      redirect_to chapters_path
    end
  end
  
  private
    def set_chapter_missions
      @chapter = Chapter.find_by_id(params[:chapter_id])
      manifests = ChapterMissionManifest.where(:chapter_id => @chapter.id).order("order" => :asc)
      @missions = []
      manifests.find_each do |manif|
        @missions.append(Mission.find_by_id(manif.mission_id))
      end
      @disabled_from = @chapter.get_disabled_from(current_user)
    end
end
