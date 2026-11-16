class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :email, null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :name, null: false, default: "" 
      t.string :provider
      t.string :uid 
      t.boolean :admin, null:false, default:false
      t.boolean :blocked, null:false, default:false
      t.string :locale, null:false, default: "en"
      t.string :theme, null:false, default: "light"
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, [:provider, :uid], unique:true 
  end
end