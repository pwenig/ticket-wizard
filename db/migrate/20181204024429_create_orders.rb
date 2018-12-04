class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.decimal :amount, :precision => 8, :scale => 2 
      t.string :order_ref
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true
      t.integer :purchased_ticket_ids, array: true, default: []
      
      t.timestamps
    end
  end
end
