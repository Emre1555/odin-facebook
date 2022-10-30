class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Gravtastic
  gravtastic

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        
  devise :omniauthable, omniauth_providers: %i[facebook]
         

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
    user.email = auth.info.email
    user.password = Devise.friendly_token[0, 20]
    user.name = auth.info.name   # assuming the user model has a name
    user.image = auth.info.image # assuming the user model has an image
    # If you are using confirmable and the provider(s) you use validate emails, 
    # uncomment the line below to skip the confirmation emails.
    # user.skip_confirmation!
  end

end
