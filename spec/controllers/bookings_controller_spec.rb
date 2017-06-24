require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  let! (:flight1) { Flight.create(
    departing_id: '1',
    arriving_id: '2',
    date: Date.new(2017, 6, 14),
    duration: 250_000
  )}

  let (:params) { 
    { booking: { flight_id: '1' },
      passengers: '2' 
    }
  }

  let (:strong_params) {
    { booking: {
        flight_id: flight1.id,
        passengers_attributes: {
            "0" => { name: "leo",
                    email: "leo@example.com" },
            "1" => { name: "mich",
                    email: "mich@example.com" } 
        }
      }
    }
  }

  describe "GET #new" do
    it "assigns the flight matching the params to @flight" do
      # flight = Flight.new
      get :new, params: params
      expect(assigns(:flight)).to eql(flight1)
    end

    it "assigns the Integer of passengers to @number" do
      get :new, params: params
      expect(assigns(:number)).to eql(2)
    end
  end

  describe "POST #create" do
    it "assigns the flight matching the params to @flight" do
      flight = Flight.new
      post :create, params: strong_params
      expect(assigns(:flight)).to eql(flight1)
    end

    it "builds a booking associated with @flight" do
      # booking = flight1.bookings.build(strong_params[:booking])
      # post :create, params: strong_params
      # expect(assigns(:booking)).to eql(booking)
      expect{ 
        post :create, params: strong_params
      }.to change{ Booking.count }.by(1)
    end

    context "with valid parameters" do
      it "redirects to the booking" do
        booking = flight1.bookings.build(strong_params[:booking])
        booking.save
        post :create, params: strong_params
        expect(response).to redirect_to action: :show,
                                        id: booking.id
      end
    end
  end

end
