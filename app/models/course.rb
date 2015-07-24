# == Schema Information
#
# Table name: courses
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  description  :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  teacher_id   :integer
#  teacher_type :string(255)
#

require "admin"

class Course < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'CourseAuthorizer'

  has_many :course_chapter_manifests
  has_many :chapters, through: :course_chapter_manifests

  belongs_to :teacher, polymorphic: true

  has_and_belongs_to_many :students, join_table: "student_courses"

  def ordered_chapters
    return Chapter.all.joins(:course_chapter_manifests).where("course_chapter_manifests.course_id = ?",self.id).order("course_chapter_manifests.order ASC")
  end

  def ordered_missions
    Mission.joins("LEFT OUTER JOIN course_chapter_manifests ON course_chapter_manifests.chapter_id = chapter_mission_manifests.chapter_id").joins(:chapter_mission_manifests).order(Arel::Table.new(:course_chapter_manifests)[:order]).order(Arel::Table.new(:chapter_mission_manifests)[:order]).where("course_chapter_manifests.course_id = ?", self.id)
  end

  def add_chapter(chapter, order=-1)
    manif = CourseChapterManifest.new
    manif.course_id = self.id
    manif.chapter_id = chapter.id
    rec = CourseChapterManifest.where(:course_id=>self.id).order(:order => :asc).last
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
        temp_manif = CourseChapterManifest.find_by(:course_id=>self.id,:order => i)
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

  def remove_chapter(chapter)
    manif = CourseChapterManifest.find_by(:course_id=>self.id,:chapter_id=>chapter.id)
    order = manif.order
    manif.delete
    rec = CourseChapterManifest.where(:course_id=>self.id).order(:order => :asc).last
    if not rec.nil?
      ((order+1)..(rec.order)).each do |i|
        manif = CourseChapterManifest.find_by(:course_id=>self.id,:order=>i)
        manif.order = manif.order-1
        manif.save
      end
    end
  end

  def get_manifest_for_chapter(chapter)
    return CourseChapterManifest.find_by(:course_id=>self.id,:chapter_id=>chapter.id)
  end

  def num_solved_chapter_for(user)
    count = 0
    self.chapters.find_each do |c|
      if c.is_solved_by?(user)
        count +=1
      end
    end
    return count
  end

  def chapter_position(chapter)
    count = 1
    self.ordered_chapters.each do |c|
      if c == chapter
        return count
      else
        count += 1
      end
    end
    return -1
  end

  def chapter_enabled?(chapter, current_user)
    return chapter_position(chapter) <= num_solved_chapter_for(current_user) + 1 || chapter.teacher == current_user || current_user.try(:has_role?,:admin)
  end

  def next_chapter_for(current_user)
    chapters = ordered_chapters
    num_solved = num_solved_chapter_for(current_user)
    if (num_solved < chapters.count)
      return chapters[num_solved]
    else
      return nil
    end
  end

  def next_exercice_url_for(current_user)
    next_chapter = next_chapter_for(current_user)
    if next_chapter.nil?
      return course_path(self)
    else
      next_mission = next_chapter.next_mission_for(current_user)
      if next_mission == next_chapter.ordered_missions.first
        return Rails.application.routes.url_helpers.course_chapter_path(self,next_chapter)
      else
        return Rails.application.routes.url_helpers.course_chapter_mission_path(self,next_chapter,next_mission)
      end
    end
  end

  def self.visible_for(user)
    if user && user.try(:has_role?,:admin)
     return Course.all.order(:id)
    elsif user && (user.has_role?(:teacher) || user.has_role?(:student))
      return user.courses.order(:id)
    elsif not user
      return Courses.all.order(:id)
    end
  end
end
