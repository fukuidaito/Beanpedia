class CreateSurveys < ActiveRecord::Migration[7.0]
  def change
    create_table :surveys do |t|
      t.integer :bitterness
      t.integer :acidity
      t.integer :body
      t.string :origin

      t.timestamps
    end
  end
end
