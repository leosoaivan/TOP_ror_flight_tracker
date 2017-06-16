class FlightsController < ApplicationController

  def index
    if params[:flight]
      @chosen_flights = Flight.where(
        departing_id: params[:flight][:departing_id],
        arriving_id:  params[:flight][:arriving_id],
        date:         Time.zone.parse(params[:flight][:date])
      )
      puts params[:flight][:date]

      unless @chosen_flights.nil?
        render :index
      end
    end
  end
end