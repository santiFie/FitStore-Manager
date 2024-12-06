class AddSubtotalToSaleItems < ActiveRecord::Migration[8.0]
  def change
    add_column :sale_items, :subtotal, :decimal, default: 0.00, null: false
  end
end
