class ChapterAuthorizer < ApplicationAuthorizer
  def self.readable_by?(user)
    true
  end
  
  def updatable_by?(user)
    modifiable_by?(user)
  end
  
  def self.updatable_by?(user)
    deletable_by?(user)
  end

  def self.creatable_by?(user)
    deletable_by?(user)
  end

  def self.deletable_by?(user)
    user.has_role? :admin or user.has_role? :teacher
  end
  
  private
    def modifiable_by?(user)
      resource.user == user or user.has_role? :admin or user.has_role? :teacher
    end
end
