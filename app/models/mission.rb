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
#  small_description        :text
#  youtube                  :string(255)
#  needs_check              :boolean          default(FALSE)
#  teacher_id               :integer
#

class Mission < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'MissionAuthorizer'

  belongs_to :teacher

  has_many :programs, :dependent=>:destroy
  has_many :file_missions, :dependent=>:destroy

  has_many :chapter_mission_manifests, :dependent=>:destroy
  has_many :chapters, through: :chapter_mission_manifests

  has_attached_file :source_code

  validates_attachment :source_code, :presence => true, :content_type => { :content_type => /text/ }
  validates :title, :description, :small_description, :presence=>true




  def is_solved_by?(user)
    if user
      program = Program.for_mission_for_user(self,user)
      return program.present? && program.solved_mission?
    else
      false
    end
  end

  def is_in_correction_for?(user)
    if user
      program = Program.for_mission_for_user(self,user)
      return program.present? && program.is_in_correction?
    else
      false
    end
  end

  def is_corrected_for?(user)
    if user
      program = Program.for_mission_for_user(self,user)
      return program.present? && program.is_corrected?
    else
      false
    end
  end

  def self.ordered_using_chapters(all=false)
    ordered_missions = Mission.all.joins(:chapter_mission_manifests).joins(:chapters).order("chapter_mission_manifests.order ASC")
    if(all)
      Mission.all.find_each do |m|
        if not ordered_missions.include?(m)
          ordered_missions.append(m)
        end
      end
      return ordered_missions
    else
      return ordered_missions
    end
    
  end

  def self.next_mission_for(user)
    if user
      stop = false
      Mission.ordered_using_chapters.each do |m|
        if not m.is_solved_by?(user)
          return m
        end
      end
      return nil
    else
      return Chapter.first.chapter_mission_manifests.order(:order).first.mission
    end
  end

  def self.visible_for(user)
    if user
      return Mission.ordered_using_chapters(all=true) if user.has_role?(:admin)
      return user.missions if user.instance_of? Teacher
    else
      self.limit(1)
    end
  end
end
