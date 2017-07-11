class CreateFlights < ActiveRecord::Migration[5.0]
  def change
    create_table :flights do |t|
      t.datetime :date
      t.time :duration
      t.references :departings, foreign_key: true
      t.references :arrivings, foreign_key: true

      t.timestamps
    end
  end
end
