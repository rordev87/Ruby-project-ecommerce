class CreateRatings < ActiveRecord::Migration[5.2]
  def change
   create_table :ratings do |t|
      t.integer :rate
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
    add_index :ratings, [:user_id, :product_id], unique: true
  end
end
