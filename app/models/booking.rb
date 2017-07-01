class Booking < ApplicationRecord
  belongs_to :flight
  has_many :passengers, inverse_of: :booking

  validates_associated :passengers
  accepts_nested_attributes_for :passengers, reject_if: :all_blank

  validates :passengers, presence: true  
end