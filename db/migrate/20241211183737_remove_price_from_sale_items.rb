class RemovePriceFromSaleItems < ActiveRecord::Migration[7.1]
  def change
    remove_column :sale_items, :price
  end
end
