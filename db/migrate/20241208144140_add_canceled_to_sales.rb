class AddCanceledToSales < ActiveRecord::Migration[7.0] # Cambia la versión si es necesario
  def change
    add_column :sales, :canceled, :boolean, default: true, null: false
  end
end
