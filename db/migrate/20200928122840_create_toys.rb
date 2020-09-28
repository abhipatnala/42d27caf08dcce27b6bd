class CreateToys < ActiveRecord::Migration[6.0]
  def change
    create_table :toys do |t|
      t.integer :x_coordinate
      t.integer :y_coordinate
      t.string :facing
      t.timestamps
    end
  end
end
