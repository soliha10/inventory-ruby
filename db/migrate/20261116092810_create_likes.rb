class CreateLikes < ActiveRecord::Migration[8.1]
  def change
    create_table :likes do |t|
      t.references :item, null:false, foreign_key: {on_delete: :cascade}, index: false
      t.references :user, null:false, foreign_key: {on_delete: :cascade}
      t.timestamps
    end
    add_index :likes, [:item_id, :user_id], unique:true
  end
end
