class RemoveGuidFromTickets < ActiveRecord::Migration[5.2]
  def up
    remove_column :tickets, :ticket_guid
    remove_column :tickets, :redeemed
    remove_column :tickets, :user_id
  end
  
  def down
    add_column :tickets, :ticket_guid, :string
    add_column :tickets, :redeemed, :boolean
    add_column :tickets, :user_id, :integer
  end
end
