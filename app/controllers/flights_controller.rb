class FlightsController < ApplicationController

  def index
    if params[:flight]
      @flights = Flight.where(
        departing_id: params[:flight][:departing_id],
        arriving_id:  params[:flight][:arriving_id],
        date:         Time.zone.parse(params[:flight][:date])
      )
      @departing_air = Airport.find(params[:flight][:departing_id])
      @arriving_air = Airport.find(params[:flight][:arriving_id])

      if @flights.empty?
        flash.now[:danger] = "Sorry, there is no such flight"
      else
        render :index
      end
    end
  end
end