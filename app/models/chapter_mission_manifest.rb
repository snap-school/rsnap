# == Schema Information
#
# Table name: chapter_mission_manifests
#
#  id         :integer          not null, primary key
#  order      :integer
#  created_at :datetime
#  updated_at :datetime
#  chapter_id :integer
#  mission_id :integer
#
# Indexes
#
#  index_chapter_mission_manifests_on_chapter_id  (chapter_id)
#  index_chapter_mission_manifests_on_mission_id  (mission_id)
#

class ChapterMissionManifest < ActiveRecord::Base
  belongs_to :chapter
  belongs_to :mission

  def before_destroy
    self.chapter.remove_mission(self.mission)
  end
end
