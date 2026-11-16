class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.references :inventory, null:false, foreign_key: {on_delete: :cascade}
      t.references :user, null:false, foreign_key: {on_delete: :cascade}
      t.text :body, null:false
      t.timestamps
    end
  end
end
