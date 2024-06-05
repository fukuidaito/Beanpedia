class AddStarsToBoards < ActiveRecord::Migration[7.0]
  def change
    add_column :boards, :stars, :integer, default: 1
  end
end
