class BookingsController < ApplicationController

  def new
    @booking = Booking.new
    @flight = Flight.find(params[:booking][:flight_id])
    @number = params[:passengers].to_i
  end

  def create
    @flight = Flight.find(booking_params[:flight_id])
    @booking = @flight.bookings.build(booking_params)
    
    if @booking.save
      redirect_to @booking
    else
      flash.now[:danger] = "#{@booking.errors.messages}"
      render :new
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  private

  def booking_params
    params.require(:booking).permit(:flight_id, passengers_attributes:[:id, :name, :email])
  end
  
end
