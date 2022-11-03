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
  
  after_create :send_welcome_email

  


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
    user = User.where(email: auth.info.email).first
    if user
      return user
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
        user.birthday = auth.info.birthday
        user.password = Devise.friendly_token[0,20]
      end
    end
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end

end
