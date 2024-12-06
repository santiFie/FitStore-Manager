class CreateClients < ActiveRecord::Migration[8.0]
  def change
    create_table :clients do |t|
      t.string :dni, null: false
      t.string :email, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.date :birth_date, null: false

      t.timestamps
    end

    add_index :clients, :dni, unique: true
    add_index :clients, :email, unique: true
  end
end
