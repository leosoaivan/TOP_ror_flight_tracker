class FlightsController < ApplicationController

  def index
    if params[:flight]
      @chosen_flight = Flight.where(
        departing_id: params[:flight][:departing_id],
        arriving_id:  params[:flight][:arriving_id],
        date:         Time.zone.parse(params[:flight][:date])
      )
    end

    unless @chosen_flight.empty?
      render :index
    else
      @message = "No such flights"
      render :index
    end
  end                       
end
