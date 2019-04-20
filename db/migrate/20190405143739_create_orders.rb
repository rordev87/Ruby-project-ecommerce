class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :note
      t.float :total_payment
	  t.string:receiver	 
	  t.string:receiving_address  
	  t.integer :state, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
