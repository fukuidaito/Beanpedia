class CreateBoardImages < ActiveRecord::Migration[7.0]
  def change
    create_table :board_images do |t|
      t.references :board, null: false, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end
