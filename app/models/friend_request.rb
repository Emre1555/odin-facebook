class FriendRequest < ApplicationRecord
  validate :not_self
  validate :not_pending 
  
  belongs_to :user
  belongs_to :friend, class_name: "User"
  

  def accept 
    user.friends << friend
    destroy
  end

  private

  def not_self
    errors.add(:friend, "can't be the same as the user") if user == friend
  end

  def not_pending
    errors.add(:friend, "is already a friend") if user.friends.include?(friend)
  end
end
