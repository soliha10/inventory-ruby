class CreateAccesses < ActiveRecord::Migration[8.1]
  def change
    create_table :accesses do |t|
      t.reference :inventory, null:false, foreign_key: {on_delete: :cascade}, index:false
      t.reference :user, null:false, foreign_key: {on_delete: :cascade}, 
      t.timestamps
    end
    add_index :accesses, [:inventory_id, :user_id], unique:true
  end
end
