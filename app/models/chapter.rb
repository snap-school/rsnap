# == Schema Information
#
# Table name: chapters
#
#  id                :integer          not null, primary key
#  title             :string(255)
#  description       :text
#  small_description :text
#  youtube           :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  teacher_id        :integer
#

class Chapter < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'ChapterAuthorizer'

  belongs_to :teacher

  has_many :chapter_mission_manifests
  has_many :missions, through: :chapter_mission_manifests

  has_many :course_chapter_manifests, :dependent=>:destroy
  has_many :courses, through: :course_chapter_manifests

  def is_solved_by?(user)
    if user
      self.missions.find_each do |m|
        if not m.is_solved_by?(user)
          return false
        end
      end
      return true
    else
      false
    end
  end

  def ordered_missions
    return Mission.all.joins(:chapter_mission_manifests).where("chapter_mission_manifests.chapter_id = ?",self.id).order("chapter_mission_manifests.order ASC")
  end

  def num_solved_missions_for(user)
    count = 0
    self.missions.find_each do |c|
      if c.is_solved_by?(user)
        count +=1
      end
    end
    return count
  end

  def mission_position(mission)
    count = 1
    self.ordered_missions.each do |m|
      if m == mission
        return count
      else
        count += 1
      end
    end
    return -1
  end

  def mission_enabled?(mission, current_user)
    return mission_position(mission) <= num_solved_missions_for(current_user) + 1 || mission.teacher == current_user || current_user.has_role?(:admin)
  end

  def next_mission_for(current_user)
    missions = ordered_missions
    num_solved = num_solved_missions_for(current_user)
    if (num_solved < missions.count)
      return missions[num_solved]
    else
      return nil
    end
  end
  
  def add_mission(mission, order=-1)
    manif = ChapterMissionManifest.new
    manif.mission_id = mission.id
    manif.chapter_id = self.id
    rec = ChapterMissionManifest.where(:chapter_id=>self.id).order(:order => :asc).last
    curr_max_order = 0
    if order == 0
      order = order + 1
    end
    if rec.nil?
      curr_max_order = 0
    else
      curr_max_order = rec.order
    end
    if order != -1 and curr_max_order > order 
      i = curr_max_order
      while i >= order do
        temp_manif = ChapterMissionManifest.find_by(:chapter_id=>self.id,:order => i)
        temp_manif.order = temp_manif.order+1
        temp_manif.save
        i = i - 1
      end
      manif.order = order
    else
      manif.order = curr_max_order + 1
    end
    manif.save
  end
  
  def remove_mission(mission)
    manif = ChapterMissionManifest.find_by(:chapter_id=>self.id,:mission_id=>mission.id)
    order = manif.order
    manif.delete
    rec = ChapterMissionManifest.where(:chapter_id=>self.id).order(:order => :asc).last
    if not rec.nil?
      ((order+1)..(rec.order)).each do |i|
        manif = ChapterMissionManifest.find_by(:chapter_id=>self.id,:order=>i)
        manif.order = manif.order-1
        manif.save
      end
    end
  end

  def get_manifest_for_mission(mission)
    return ChapterMissionManifest.find_by(:chapter_id=>self.id,:mission_id=>mission.id)
  end

  def self.visible_for(user)
    if user
      if user.has_role?(:admin)
        return Chapter.all
      elsif user.instance_of? Teacher
        return user.chapters
      end
    else
      return Chapter.limit(1)
    end
  end

end
