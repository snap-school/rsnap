class UserAuthorizer < ApplicationAuthorizer
  def self.default(adjective, user)
    true
  end

  def readable_by?(user)
    modifiable_by?(user)
  end

  def updatable_by?(user)
    modifiable_by?(user)
  end

  def deletable_by?(user)
    modifiable_by?(user)
  end

  private
    def modifiable_by?(user)
      user.has_role? :admin or resource == user
    end
end
