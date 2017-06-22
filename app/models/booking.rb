class Booking < ApplicationRecord
  belongs_to :flight
  has_many :passengers

  accepts_nested_attributes_for :flight
  accepts_nested_attributes_for :passengers
end