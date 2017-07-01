class BookingsController < ApplicationController

  def new
    @booking = Booking.new
    @flight = Flight.find(params[:booking][:flight_id])
    @number = params[:passengers].to_i
    @departing_air = Airport.find(@flight.departing_id)
    @arriving_air = Airport.find(@flight.arriving_id)
  end

  def create
    @flight = Flight.find(booking_params[:flight_id])
    @booking = @flight.bookings.build(booking_params)
    permitted_params = booking_params.to_h    

    if @booking.save
      flash[:success] = "Your flight has been booked"
      redirect_to @booking
    else
      flash.now[:danger] = "Passenger information can't be blank"

      @booking = Booking.new
      @flight = Flight.find(permitted_params[:flight_id])
      @number = permitted_params[:passengers_attributes].count
      @departing_air = Airport.find(@flight.departing_id)
      @arriving_air = Airport.find(@flight.arriving_id)

      render :new
    end
  end

  def show
    @booking = Booking.find(params[:id])
    @flight = Flight.find(@booking.flight_id)
    @departing_air = Airport.find(@flight.departing_id)
    @arriving_air = Airport.find(@flight.arriving_id)
    @confirmation
  end

  private

  def booking_params
    params.require(:booking).permit(
      :flight_id,
      passengers_attributes:[:id, :name, :email]
    )
  end

  
end
