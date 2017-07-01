require 'rails_helper'

RSpec.describe Booking, type: :model do
  let (:flight1) { Flight.create(
    departing_id: '1',
    arriving_id: '2',
    date: Date.new(2017, 6, 14),
    duration: 250_000
  )}

  let! (:airport1) {Airport.create(
    name: "Airport 1",
    code: "Air1"
  )}

  let! (:airport2) {Airport.create(
    name: "Airport 2",
    code: "Air2"
  )}

  let (:strong_params) {
    { booking: {
        flight_id: flight1.id,
        passengers_attributes: {
            "0" => { name: "leo",
                    email: "leo@example.com" },
            "1" => { name: "mich",
                    email: "mich@example.com" } 
        }
      }
    }
  }
 
  it { should belong_to(:flight) }
  it { should have_many(:passengers) }

  describe "#relevant_aiports" do
    it "returns the flight's departing airport" do
      booking = flight1.bookings.build(strong_params[:booking])
      airports = booking.relevant_airports(flight1)
      expect(airports[:departing]).to eql(airport1)
    end

    it "returns the flight's arriving airport" do
      booking = flight1.bookings.build(strong_params[:booking])
      airports = booking.relevant_airports(flight1)
      expect(airports[:arriving]).to eql(airport2)
    end
  end
end
