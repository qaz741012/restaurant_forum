class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name

  mount_uploader :avatar, AvatarUploader

  has_many :comments, dependent: :restrict_with_error

  has_many :restaurants, through: :comments

  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant

  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant

  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id", dependent: :destroy
  has_many :followers, through: :inverse_followships, source: :user

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :request_friend, through: :inverse_friendships, source: :user

  def admin?
    self.role == "admin"
  end

  def following?(user)
    self.followings.include?(user)
  end

  def send_request?(user)
    if self.friends.include?(user)
      self.friendships.find_by(friend_id: user.id).status == "request"
    else
      false
    end
  end

  def be_friend_with?(user)
    if self.friends.include?(user)
      self.friendships.find_by(friend_id: user.id).status == "confirm"
    else
      false
    end
  end

  def unconfirm_friends
    unconfirm_friendships = self.friendships.where(status: "unconfirm")
    unconfirm_friends = []
    unconfirm_friendships.each do |unconfirm_friendship|
      unconfirm_friends << User.find(unconfirm_friendship.friend_id)
    end
    return unconfirm_friends
  end

  def request_friends
    request_friendships = self.friendships.where(status: "request")
    request_friends = []
    request_friendships.each do |request_friendship|
      request_friends << User.find(request_friendship.friend_id)
    end
    return request_friends
  end


end
