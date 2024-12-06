class CreateSales < ActiveRecord::Migration[8.0]
  def change
    create_table :sales do |t|
      t.datetime :sale_date, null: false
      t.decimal :total, null: false, precision: 10, scale: 2
      t.references :user, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
