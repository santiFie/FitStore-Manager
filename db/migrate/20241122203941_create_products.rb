class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :unit_price
      t.integer :available_stock
      t.string :category
      t.string :size
      t.string :color
      t.date :entry_date
      t.datetime :last_modified_at
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
