class AddBlockedToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :blocked, :boolean, default: false, null: false
  end
end
