class CreateSuggestions < ActiveRecord::Migration[5.2]
  def change
     create_table :suggestions do |t|
      t.string :category_name
      t.string :product_name
      t.integer :price
      t.text :description
      t.string :image
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
