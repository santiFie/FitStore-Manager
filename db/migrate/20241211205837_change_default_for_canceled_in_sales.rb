class ChangeDefaultForCanceledInSales < ActiveRecord::Migration[6.0]
  def change
    change_column_default :sales, :canceled, from: true, to: false
  end
end
