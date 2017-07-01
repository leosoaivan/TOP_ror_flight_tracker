require 'rails_helper'

RSpec.describe Passenger, type: :model do
  let(:booking) { Booking.new }
  let(:passenger) { 
    booking.passengers.build(name: "LPSV", email: "example@email.com")
  }

  it { should belong_to(:booking) }

  it "is valid with a name and email" do
    expect(passenger).to be_valid
  end
  
  it "is invalid without a name" do
    passenger.name = nil
    expect(passenger).to_not be_valid
  end
  
  it "is invalid without a name" do
    passenger.email = nil
    expect(passenger).to_not be_valid
  end

end
