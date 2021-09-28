class AddIndexOnCountryInAirport < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!
  def change
    add_index :airports, :country, algorithm: :concurrently
  end
end
