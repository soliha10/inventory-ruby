class CreateTags < ActiveRecord::Migration[8.1]
  def change
    create_table :tags do |t|
      t.string :name, null: false, index: {unique:true}
      t.timestamps
    end
    create_table :taggings do |t|
      t.references :tag, null:false, foreign_key: {on_delete: :cascade}
      t.references :inventory, null:false, foreign_key: {on_delete: :cascade}, index:false
      t.timestamps
    end
    add_index :taggings, [:inventory_id, :tag_id], unique: true
  end
end
