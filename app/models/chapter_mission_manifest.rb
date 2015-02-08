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

class ChapterMissionManifest < ActiveRecord::Base
  belongs_to :chapter
  belongs_to :mission
end
