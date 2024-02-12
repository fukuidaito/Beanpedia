class AddTasteRatingsToBoards < ActiveRecord::Migration[7.0]
  def change
    add_column :boards, :acidity, :integer, null: false
    add_column :boards, :bitterness, :integer, null: false
    add_column :boards, :richness, :integer, null: false
  end
end
