class CreateFields < ActiveRecord::Migration[8.1]
  def change
    create_table :fields do |t|
      t.references :inventory, null: false, foreign_key: {on_delete: :cascade}
      t.string :kind, null: false
      t.integer :slot, null:false
      t.string :title, null: false
      t.string :description, null: false, default: ""
      t.boolean :show_in_table, null:false, default: false
      t.integer :position, null:false, default: 0
      t.timestamps
    end
    add_index :fields, [:inventory_id, :kind, :slot], unique:true
  end
end
