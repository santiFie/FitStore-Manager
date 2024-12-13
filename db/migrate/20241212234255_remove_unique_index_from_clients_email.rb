class RemoveUniqueIndexFromClientsEmail < ActiveRecord::Migration[6.1]
  def change
    remove_index :clients, name: "index_clients_on_email"
    add_index :clients, :email # Agregar índice normal sin la restricción de unicidad
  end
end
