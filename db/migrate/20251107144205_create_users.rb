class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :encrypted_password, null: false
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.integer :role
      t.string :provider, limit: 64
      t.string :uid
      t.string :x_account
      t.string :instagram_account
      t.string :facebook_account
      t.boolean :email_reminder_enabled, default: false
      t.string :timezone

      t.timestamps
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, [:provider, :uid], unique: true
  end

end
