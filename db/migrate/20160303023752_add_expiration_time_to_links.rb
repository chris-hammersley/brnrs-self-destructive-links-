class AddExpirationTimeToLinks < ActiveRecord::Migration
  def change
    add_column :links, :expiration_time, :timestamp
  end
end