# == Schema Information
#
# Table name: missions
#
#  id                       :integer          not null, primary key
#  title                    :string(255)
#  description              :text
#  source_code_file_name    :string(255)
#  source_code_content_type :string(255)
#  source_code_file_size    :integer
#  source_code_updated_at   :datetime
#  created_at               :datetime
#  updated_at               :datetime
#  mission_order            :integer          default(0)
#  small_description        :text
#  youtube                  :string(255)
#

class Mission < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'MissionAuthorizer'

  has_many :programs, :dependent=>:destroy
  has_many :file_missions, :dependent=>:destroy

  has_many :chapter_mission_manifests, :dependent=>:destroy
  has_many :chapters, through: :chapter_mission_manifests

  has_attached_file :source_code

  validates_attachment :source_code, :presence => true, :content_type => { :content_type => /text/ }
  validates :title, :description, :small_description, :presence=>true

  include RankedModel
  ranks :mission_order
  default_scope {rank(:mission_order)}

  def position(scope=:all)
    Mission.send(scope).index(self) + 1
  end

  def is_solved_by?(user)
    if user
      programs.where(:user=>user).present?
    else
      false
    end
  end

  def self.next_mission_for(user)
    if user
      chapter = Chapter.next_chapter_for(user)
      if not chapter
        return nil
      else
        chapter.chapter_mission_manifests.each do |manif|
          m = manif.mission
          if m
            if not m.is_solved_by?(user)
              return m
            end
          end
        end
      end
      return nil
    else
      return Chapter.first.chapter_mission_manifests.first.mission
    end
  end

  def self.visible_for(user)
    if user
      return Mission.all if user.has_role?(:admin)
      solved_missions = 0
      last_solved_program = user.programs.order_by_missions.last
      solved_missions = last_solved_program.mission.position if last_solved_program
      self.limit(solved_missions + 1)
    else
      self.limit(1)
    end
  end
end
