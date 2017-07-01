class Booking < ApplicationRecord
  belongs_to :flight
  has_many :passengers, inverse_of: :booking

  validates_associated :passengers
  accepts_nested_attributes_for :passengers, reject_if: :all_blank

  validates :passengers, presence: true

  def relevant_airports(flight)
    airports = { 
      departing: Airport.find(flight.departing_id),
      arriving: Airport.find(flight.arriving_id)
    }
  end
end