class Flight < ApplicationRecord
  belongs_to :departing, :class_name => "Airport"
  belongs_to :arriving,  :class_name => "Airport"

  def flight_date_formatted
    date.strftime("%m/%d/%Y")
  end

end
