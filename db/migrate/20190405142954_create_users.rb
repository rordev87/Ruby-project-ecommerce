class CreateUsers < ActiveRecord::Migration[5.2]

  def change
    create_table :users do |t|
      t.string :user_name
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.string :avatar, default: "/assets/new_user.png"
      t.string :address
      t.datetime :date_of_birth
      t.boolean :is_admin, default: false
      t.boolean :activated, default: false
      t.string :activation_digest
      t.datetime :activated_at

      t.timestamps

    end
  end
end
