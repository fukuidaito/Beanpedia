class User < ApplicationRecord
  attr_accessor :remember_token
  mount_uploader :avatar, AvatarUploader
  has_many :boards, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy 
  has_many :bookmark_boards, through: :bookmarks, source: :board
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },format: { with: VALID_EMAIL_REGEX },uniqueness: true

  has_secure_password

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest
  end

  def session_token
    remember_digest || remember
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def own?(resource)
    self.id == resource.user_id
  end

  # ブックマークに追加する
  def bookmark(board)
    bookmark_boards << board
  end
  
  # ブックマークを外す
  def unbookmark(board)
    bookmark_boards.destroy(board)
  end
  
  # ブックマークをしているか判定する
  def bookmark?(board)
    bookmark_boards.include?(board)
  end
end
