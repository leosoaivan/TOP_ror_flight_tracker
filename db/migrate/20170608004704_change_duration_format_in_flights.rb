class ChangeDurationFormatInFlights < ActiveRecord::Migration[5.0]
  def change
    change_column :flights, :duration, :integer
  end
end
