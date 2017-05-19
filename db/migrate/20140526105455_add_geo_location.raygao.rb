# added by raygao to accommodate geo-spatial capability.
class AddGeoLocation < ActiveRecord::Migration

  def up
      add_column :spree_addresses, :geo_lat, :string, :limit => 50
      add_column :spree_addresses, :geo_long, :string, :limit => 50
  end

  def down
    remove_column :spree_addresses, :geo_lat
    remove_column :spree_addresses, :geo_lat
  end
end