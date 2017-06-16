class Flight < ApplicationRecord
  belongs_to :departing, :class_name => "Airport"
  belongs_to :arriving,  :class_name => "Airport"

  validates :departing_id, presence: true
  validates :arriving_id, presence: true

  # Returns an ActiveRecord::Relation for use with #collection_select. The alternative is to create an array via pluck, to be used with options_for_select, though it does not allow for the use of text_methods.
  def self.distinct_dates
    select(:date).order(:date).distinct
  end

  # To be used as text_method in #collection_select
  def flight_date_formatted
    date.strftime("%m/%d/%Y")
  end

end