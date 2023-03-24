class UserPolicy < ApplicationPolicy
  def friend?
    user.friends.include?(record)
  end
end
