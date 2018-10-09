class CreatePurchasedTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :purchased_tickets do |t|
      t.string :ticket_guid
      t.boolean :redeemed, null: false, default: false
      t.string :barcode
      t.references :event, index: true, foreign_key: true
      t.references :ticket, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
