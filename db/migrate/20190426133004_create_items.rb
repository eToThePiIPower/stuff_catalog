class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :isbn
      t.string :title
      t.decimal :value, precision: 16, scale: 2

      t.timestamps
    end
  end
end
