class ChapterMissionsController < ApplicationController
  authorize_actions_for Chapter
  before_action :set_chapter_missions, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except=>[:index, :show]

  def index
    redirect_to chapters_path
  end

  def show
    @title = "Chapitre : #{@chapter.title}"
  end

  def update
    respond_to do |format|
      format.json do
        if @chapter.update(mission_params)
          render @chapter
        end
      end
    end
  end
  
  private
    def set_chapter_missions
      @chapter = Chapter.find_by_id(params[:id])
      manifests = ChapterMissionManifest.where(:chapter_id => @chapter.id).order("order" => :asc)
      @missions = []
      manifests.each do |manif|
        @missions.append(Mission.find_by_id(manif.mission_id))
      end
      @disabled_from = @chapter.get_disabled_from(current_user)
    end
end
