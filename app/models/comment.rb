class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :board, inverse_of: :comments
  validates :body, presence: true, length: { maximum: 65_535 }
end
