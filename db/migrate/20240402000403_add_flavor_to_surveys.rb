class AddFlavorToSurveys < ActiveRecord::Migration[7.0]
  def change
    add_column :surveys, :flavor, :string
  end
end
