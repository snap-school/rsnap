class ChapterMissionManifestController < ApplicationController
  before_action :set_manifest, only: [:destroy]

  def destroy
    authorize_action_for @manifest.chapter
    chapter_id = @manifest.chapter_id
    @manifest.delete
    redirect_to chapter_missions_path(chapter_id), notice: "La mission a bien été retirée du chapitre."
  end

  private
    def set_manifest
      @manifest = ChapterMissionManifest.find_by(:id => params[:id])
    end

end
