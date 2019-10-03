class AddStartDatetimeAndFlightDurationToFlights < ActiveRecord::Migration[6.0]
  def change
    add_column :flights, :start, :datetime
    add_column :flights, :duration, :integer
  end
end
