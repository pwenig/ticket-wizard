class AddGuidToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :event_guid, :string
  end
end
