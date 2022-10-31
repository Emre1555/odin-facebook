class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Gravtastic
  gravtastic
        
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :friend_requests, dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy
  


  def active_friends
    friends.select{ |friend| friend.friends.include?(self) }  
  end
  
  def pending_friends
    friends.select{ |friend| !friend.friends.include?(self) }  
  end

  def remove_friend(friend)
    friendship = friendships.find_by(friend: friend)
    friendship.destroy
  end

  def friend?(user)
    friends.include?(user)
  end

  def friend_request_sent?(user)
    @friend_request = FriendRequest.where(user: self, friend: user)
  end 

  def friend_request_received?(user)
    @friend_request = FriendRequest.where(user: user, friend: self)
  end


  def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.provider = auth.provider
    user.uid = auth.uid
    user.password = Devise.friendly_token[0,20]
  end
end

end
