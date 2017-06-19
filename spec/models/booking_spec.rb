require 'rails_helper'

RSpec.describe Booking, type: :model do
  it { should belong_to(:flight) }
  it { should belong_to(:passenger) }
end
