class CourseAuthorizer < ApplicationAuthorizer
  def self.readable_by?(user)
    true
  end
  
  def updatable_by?(user)
    modifiable_by?(user)
  end

  private
    def modifiable_by?(user)
      resource.user == user or user.has_role? :admin
    end
end
