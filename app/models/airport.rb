class Airport < ApplicationRecord
  has_many :departures, foreign_key: :departing_id, :class_name => "Flight"
  has_many :arrivals, foreign_key: :arriving_id, :class_name => "Flight"

  def code_with_name
    "#{code} - #{name} Int'l Airport"
  end
  
end