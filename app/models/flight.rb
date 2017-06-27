class Flight < ApplicationRecord
  belongs_to :departing, :class_name => "Airport"
  belongs_to :arriving,  :class_name => "Airport"
  
  has_many :bookings

  validates :departing_id, presence: true
  validates :arriving_id, presence: true

  # Returns an ActiveRecord::Relation for use with #collection_select. The alternative is to create an array via pluck, to be used with options_for_select, though it does not seem to allow for the use of text_methods.
  def self.distinct_dates
    select(:date).order(:date).distinct
  end

  # To be used as text_method in #collection_select
  def date_formatted
    date.strftime("%m/%d/%Y")
  end

  def time_formatted
    time.getlocal.strftime("%I:%M%P")
  end

  def arriving_formatted
    arriving.getlocal.strftime("%I:%M%P")
  end

  def duration_formatted
    hours, remaining_secs = self.duration.divmod(3600)
    minutes = remaining_secs / 60
    "#{hours}h #{minutes}m"
  end

  private

    def arriving
      (self.time + self.duration.seconds).getlocal
    end

end