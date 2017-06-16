require 'rails_helper'

RSpec.describe Airport, type: :model do
  it { should have_many(:departures).with_foreign_key(:departing_id).class_name("Flight")}
  it { should have_many(:arrivals).with_foreign_key(:arriving_id).class_name("Flight")}
end
