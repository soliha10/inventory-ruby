class CreateItems < ActiveRecord::Migration[8.1]
  def change
    create_table :items do |t|
      t.references :inventory, null:false, foreign_key: {on_delete: :cascade}, index: false
      t.references :creator, null:false, foreign_key: {to_table: :users, on_delete: : :cascade}
      t.string :custom_id, null:false
      t.integer :sequence_number, null:false, default: 0
      t.integer :lock_version, null:false, default: 0
      (1..3).each do |n|
        t.string "string_#{n}"
        t.text "text_#{n}"
        t.decimal "number_#{n}"
        t.string "link_#{n}"
        t.boolean "boolean_#{n}"
      end
      t.timestamps
    end
    add_index :items, [:inventory_id, :custom_id], unique:true
  end
end
