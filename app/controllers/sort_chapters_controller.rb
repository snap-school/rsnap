class SortChaptersController < ApplicationController
  authorize_actions_for Chapter
  before_filter :authenticate_user!

  def update
    @chapter = Chapter.find(params[:id])
    @chapter.update(chapter_params)
    render nothing: true # action called via ajax
  end

  private
    def chapter_params
      params.require(:thing).permit(:chapter_order_position)
    end
end

