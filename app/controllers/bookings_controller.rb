class BookingsController < ApplicationController

  def new
    @booking = Booking.new
    @flight = Flight.find(params[:booking][:flight_id])
    @number = params[:passengers].to_i
    @airports = @booking.relevant_airports(@flight)
  end

  def create
    @flight = Flight.find(booking_params[:flight_id])
    @booking = @flight.bookings.build(booking_params)
    permitted_params = booking_params.to_h
    @passengers = permitted_params[:passengers_attributes]

    if @booking.save
      redirect_to @booking
      @passengers.each_value do |passenger|
        ConfirmationMailer.confirmation_email(passenger).deliver_later
      end
    else
      flash.now[:danger] = "Passenger information can't be blank"

      @booking = Booking.new
      @flight = Flight.find(permitted_params[:flight_id])
      @number = permitted_params[:passengers_attributes].count
      @airports = @booking.relevant_airports(@flight)

      render :new
    end
  end

  def show
    @booking = Booking.find(params[:id])
    @flight = Flight.find(@booking.flight_id)
    @airports = @booking.relevant_airports(@flight)
  end

  private

  def booking_params
    params.require(:booking).permit(
      :flight_id,
      passengers_attributes:[:id, :name, :email]
    )
  end

  
end
