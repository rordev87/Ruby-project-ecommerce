class CreateProducts < ActiveRecord::Migration[5.2]
  def change
     create_table :products do |t|
      t.string :product_name
      t.string :product_image
      t.text :product_details
      t.boolean :product_sale_off, default: false
      t.integer :price_normal
      t.integer :price_sale_off
      t.boolean :is_hot, default: false
      t.integer :quanlity
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
