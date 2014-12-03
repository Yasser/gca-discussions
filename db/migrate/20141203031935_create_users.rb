class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.integer :uid
      t.string :first_name
      t.string :last_name
      t.string :title
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip
      t.boolean :admin

      t.timestamps
    end
  end
end
