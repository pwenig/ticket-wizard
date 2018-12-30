class AddOpsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :ops, :boolean, default: false
  end
end
