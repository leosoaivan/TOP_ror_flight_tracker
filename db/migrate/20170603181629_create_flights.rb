class CreateFlights < ActiveRecord::Migration[5.0]
  def change
    create_table :flights do |t|
      t.datetime :date
      t.time :duration
      t.references :departing, foreign_key: true
      t.references :arriving, foreign_key: true

      t.timestamps
    end
  end
end
