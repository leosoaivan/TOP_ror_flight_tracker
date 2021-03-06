require 'rails_helper'

RSpec.describe Flight, type: :model do
  let (:flight) { Flight.create(
    departing_id: '1',
    arriving_id: '2',
    date: Date.new(2017, 6, 14),
    time: Time.new(2017, 6, 14, 4, 4, 4),
    duration: 25_000
  )}

  let (:flight2) { Flight.create(
    departing_id: '2',
    arriving_id: '3',
    date: Date.new(2017, 6, 22),
    duration: 21_000
  )}

   let (:flight3) { Flight.create(
    departing_id: '3',
    arriving_id: '4',
    date: Date.new(2017, 6, 22),
    duration: 25_000
  )}

  it { should belong_to(:departing).class_name("Airport") }
  it { should belong_to(:arriving).class_name("Airport") }
  it { should have_many(:bookings) }
  
  it "is valid with a departing_id and an arriving_id" do
    flight
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
    it "returns an ActiveRecord::Relation" do
      expect(Flight.distinct_dates).to be_an(ActiveRecord::Relation)
    end

    it "returns sorted and unique flight dates" do
      flight
      flight2
      flight3
      flights = Flight.distinct_dates.pluck(:date)
      expect(flights).to include(flight.date, flight2.date)
    end
  end

  # See Flight model for notes
  describe "#date_formatted" do
    it "formats Date/Time to a mm/dd/yyyy String" do
      expect(flight.date_formatted).to eql("06/14/2017")
    end
  end

  describe "#time_formatted" do
    it "formats Time to a H:MMam/pm String" do
      expect(flight.time_formatted).to eql("04:04am")
    end
  end

  describe "#duration_formatted" do
    it "formats the duration from Integer seconds to HH:MM String" do
      expect(flight.duration_formatted).to eql("6h 56m")
    end
  end

  describe "#arriving_formatted" do
    it "returns the arriving time in a H:MMam/pm String" do
      expect(flight.arriving_formatted).to eql("11:00am")
    end
  end
end