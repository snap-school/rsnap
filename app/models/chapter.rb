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
#  chapter_order     :integer          default(0)
#

class Chapter < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'ChapterAuthorizer'

  has_many :chapter_mission_manifests
  has_many :missions, through: :chapter_mission_manifests

  include RankedModel
  ranks :chapter_order
  default_scope {rank(:chapter_order)}

  def position(scope=:all)
    Chapter.send(scope).index(self) + 1
  end

  def self.visible_for(user)
    if user
      if user.has_role?(:admin)
        return Chapter.all
      end
      num_solved_chapter = 0
      Chapter.all.each do |chapter|
        break if not chapter.is_solved_by?(user)
        num_solved_chapter = num_solved_chapter + 1
      end
      Chapter.limit(num_solved_chapter + 1)
    else
      return Chapter.limit(1)
    end
  end

  def is_solved_by?(user)
    if user
      self.missions.each do |m|
        if not m.is_solved_by?(user)
          return false
        end
      end
      return true
    else
      false
    end
  end

  def self.next_chapter_for(user)
    if user
      Chapter.all.each do |c|
        if not c.is_solved_by?(user)
          return c
        end
      end
      return nil
    else
      return Chapter.first
    end
  end
  
  def get_disabled_from(user)
    if user
      return self.missions.count if user.has_role?(:admin)
      solved = 0
      self.missions.each do |mission|
        if mission.is_solved_by?(user)
          solved = solved + 1
        end
      end
      return solved + 1
    end
    1
  end
  
  def add_mission(mission, order=-1)
    manif = ChapterMissionManifest.new
    manif.mission_id = mission.id
    manif.chapter_id = self.id
    rec = ChapterMissionManifest.where(:chapter_id=>self.id).order("order"=> :asc).last
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
        temp_manif = ChapterMissionManifest.find_by(:chapter_id=>self.id,"order"=> i)
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
    rec = ChapterMissionManifest.where(:chapter_id=>self.id).order("order"=> :asc).last
    if not rec.nil?
      ((order+1)..(rec.order)).each do |i|
        manif = ChapterMissionManifest.find_by(:chapter_id=>self.id,"order"=> i)
        manif.order = manif.order-1
        manif.save
      end
    end
  end
  
end
