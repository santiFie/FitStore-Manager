class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :unit_price
      t.integer :available_stock
      t.string :size
      t.string :color
      t.date :entry_date, default: -> { 'CURRENT_DATE' }
      t.datetime :last_modified_at
      t.datetime :deleted_at, null: true
      t.references :category, null: false, foreign_key: true # Agregar clave foránea

      t.timestamps
    end
  end
end
