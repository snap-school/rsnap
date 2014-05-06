class ProjectAuthorizer < ProgramAuthorizer
  def self.deletable_by?(user)
    true
  end

  def deletable_by?(user)
    modifiable_by?(user)
  end
end
