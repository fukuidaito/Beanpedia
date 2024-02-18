class Board < ApplicationRecord
  mount_uploader :board_image, BoardImageUploader
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy 

	validates :title, presence: true, length: { maximum: 255 }
	validates :body, presence: true, length: { maximum: 65_535 }
  enum acidity: { very_low: 1, low: 2, medium: 3, high: 4, very_high: 5 }, _prefix: true
  enum bitterness: { very_low: 1, low: 2, medium: 3, high: 4, very_high: 5 }, _prefix: true
  enum richness: { very_low: 1, low: 2, medium: 3, high: 4, very_high: 5 }, _prefix: true

  def self.ranking
    Board.select('boards.*, COUNT(bookmarks.id) AS bookmarks_count').joins(:bookmarks).group('boards.id').order('bookmarks_count DESC')
  end
end
