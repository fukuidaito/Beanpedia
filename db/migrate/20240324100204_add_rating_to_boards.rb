class AddRatingToBoards < ActiveRecord::Migration[7.0]
  def change
    add_column :boards, :rating, :integer
  end
end
