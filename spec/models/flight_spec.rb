require 'rails_helper'

RSpec.describe Flight, type: :model do
  let! (:flight) { Flight.create(
    departing_id: '1',
    arriving_id: '2',
    date: Date.new(2017, 6, 14),
    duration: 250_000
  )}

  let! (:flight2) { Flight.create(
    departing_id: '2',
    arriving_id: '3',
    date: Date.new(2017, 6, 22),
    duration: 251_000
  )}

   let! (:flight3) { Flight.create(
    departing_id: '3',
    arriving_id: '4',
    date: Date.new(2017, 6, 22),
    duration: 255_000
  )}

  it { should belong_to(:departing).class_name("Airport") }
  it { should belong_to(:arriving).class_name("Airport") }
  
  it "is valid with a departing_id and an arriving_id" do
    expect(flight).to be_valid
  end
  
  it "is invalid without a departing_id" do
    flight.departing_id = nil
    expect(flight).to_not be_valid
  end

  it "is invalid without an arriving_id" do
    flight.arriving_id = nil
    expect(flight).not_to be_valid
  end

  # See Flight model for notes
  describe ".distinct_dates" do
    it "returns an ActiveRecord::Relation with unique and sorted dates" do
      expect(Flight.distinct_dates).to be_an(ActiveRecord::Relation)
    end

    it "returns sorted and unique flight dates" do
      flights = Flight.distinct_dates.pluck(:date)
      expect(flights).to include(flight.date, flight2.date)
    end
  end
  
  # See Flight model for notes
  describe "#flight_date_formatted" do
    it "formats Date/Time to a mm/dd/yyyy String" do
      expect(flight.flight_date_formatted).to eql("06/14/2017")
    end
  end

end
