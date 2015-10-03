class ProgramAuthorizer < ApplicationAuthorizer
  def self.readable_by?(user)
    true
  end

  def readable_by?(user)
    modifiable_by?(user)
  end

  def self.creatable_by?(user)
    true
  end

  def creatable_by?(user)
    modifiable_by?(user)
  end

  def self.updatable_by?(user)
    true
  end

  def updatable_by?(user)
    modifiable_by?(user)
  end

  def deletable_by?(user)
    user.has_role? :admin or user.has_role? :teacher
  end

  private
    def modifiable_by?(user)
      resource.user == user or user.has_role? :admin or user.has_role? :teacher
    end
end
