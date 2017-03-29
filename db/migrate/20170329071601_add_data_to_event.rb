class AddDataToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :opener_name, :string
    add_column :events, :headliner_name, :string
    add_column :events, :description, :text
    add_column :events, :venue_name, :string
    add_column :events, :venue_id, :string
    add_column :events, :starts_at, :timestamp
    add_column :events, :doors_time, :string
    add_column :events, :advance_price, :string
    add_column :events, :door_price, :string
    add_column :events, :tickets, :string
    add_column :events, :vendor_id, :string
    add_column :events, :vendor_url, :string
    add_column :events, :image_url, :string
    add_column :events, :twitter_url, :string
    add_column :events, :soundcloud_url, :string

    add_index :events, :starts_at
  end
end
