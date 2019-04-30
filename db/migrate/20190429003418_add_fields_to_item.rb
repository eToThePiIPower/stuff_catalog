class AddFieldsToItem < ActiveRecord::Migration[5.2]
  def change
    change_table :items, bulk: true do |t|
      t.string :authors, array: true, default: []
      t.string :categories, array: true, default: []
      t.text :description
      t.string :publisher
      t.date :publisher_on
      t.integer :page_count
    end
  end
end
