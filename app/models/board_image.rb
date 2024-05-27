class BoardImage < ApplicationRecord
  belongs_to :board, class_name: 'Board', inverse_of: :board_images
  mount_uploader :image, BoardImageUploader

  validates :image, presence: true
end
