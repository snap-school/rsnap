class ChapterMissionsController < ApplicationController
  authorize_actions_for Chapter
  before_action :set_chapter_missions, only: [:index]
  before_action :set_course
  before_filter :authenticate_user!, except: [:index]

  def index
    @title = "Chapitre : #{@chapter.title}"
    @from_chapter = true
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
      @missions = @chapter.ordered_missions
    end

    def set_course
      @course = params[:course_id].nil? ? nil : Course.find_by_id(params[:course_id])
      @from_course = !params[:course_id].nil?
    end
end
