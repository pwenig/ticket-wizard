class AddAdminToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :stripe_publishable_key, :string
    add_column :users, :stripe_secret_key, :string
  end
end
