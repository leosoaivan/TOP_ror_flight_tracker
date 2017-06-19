class AddTimeToFlights < ActiveRecord::Migration[5.0]
  def change
    add_column :flights, :time, :datetime
  end
end
