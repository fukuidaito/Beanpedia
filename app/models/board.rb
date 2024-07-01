class Board < ApplicationRecord
  belongs_to :user
  has_many :comments, -> { order(created_at: :desc) }, dependent: :destroy, inverse_of: :board
  has_many :bookmarks, dependent: :destroy
  has_many :board_images, dependent: :destroy, class_name: 'BoardImage', inverse_of: :board
  has_many :reviews, dependent: :destroy

  accepts_nested_attributes_for :board_images, allow_destroy: true

  enum acidity: { very_low: 1, low: 2, medium: 3, high: 4, very_high: 5 }, _prefix: true
  enum bitterness: { very_low: 1, low: 2, medium: 3, high: 4, very_high: 5 }, _prefix: true
  enum richness: { very_low: 1, low: 2, medium: 3, high: 4, very_high: 5 }, _prefix: true

  mount_uploader :board_image, BoardImageUploader

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }

  geocoded_by :address
  after_validation :geocode

  def image_url
    board_images.first&.image&.url
  end

  def average_rating
    reviews.count.zero? ? 0 : reviews.average(:stars).round(1)
  end

  def self.ranking
    Board.select('boards.*, COUNT(bookmarks.id) AS bookmarks_count')
         .joins(:bookmarks)
         .group('boards.id')
         .order('bookmarks_count DESC')
  end

  def bookmarks_count
    bookmarks.count
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[bookmarks comments user]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[acidity address bitterness board_image body created_at id latitude longitude richness title updated_at user_id]
  end
end
