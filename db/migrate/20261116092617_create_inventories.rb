class CreateInventories < ActiveRecord::Migration[8.1]
  def change
    create_table :inventories do |t|
      t.references :creator, null:false, foreign_key: {to_table: :users, on_delete: :cascade}
      t.references :category, null:false , foreign_key: true
      t.string :title, null:false
      t.text :description, null:false, default: ""
      t.boolean :public, null:false, default: false
      t.integer :lock_version, null:false, default: 0
      t.timestamps
    end
    add_index :inventories, :created_at
  end
end
