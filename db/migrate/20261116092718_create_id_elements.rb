class CreateIdElements < ActiveRecord::Migration[8.1]
  def change
    create_table :id_elements do |t|
      t.references :inventory, null:false, foreign_key: {on_delete: :cascade}
      t.string :kind, null: false
      t.string :value, null:false, default: ""
      t.integer :position, null:false, default: 0
      t.timestamps
    end
  end
end
