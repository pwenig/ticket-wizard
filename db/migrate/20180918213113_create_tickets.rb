class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.string :title
      t.decimal :price, :precision => 8, :scale => 2 
      t.integer :qty_available
      t.text :description
      t.datetime :onsale_start
      t.datetime :onsale_end
      t.string :ticket_guid
      t.boolean :redeemed, :default => false
      t.references :event, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end
