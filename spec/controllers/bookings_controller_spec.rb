require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  let (:flight1) { Flight.create(
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

  let (:wrong_params) {
    { booking: {
        flight_id: flight1.id,
        passengers_attributes: {
            "0" => { name: nil,
                    email: "leo@example.com" },
            "1" => { name: "mich",
                    email: "" } 
        }
      }
    }
  }

  describe "GET #new" do
    it "assigns the flight matching the params to @flight" do
      flight1
      get :new, params: params
      expect(assigns(:flight)).to eql(flight1)
    end

    it "assigns the Integer of passengers to @number" do
      flight1
      get :new, params: params
      expect(assigns(:number)).to eql(params[:passengers].to_i)
    end
  end

  describe "POST #create" do
    it "assigns the flight matching the params to @flight" do
      post :create, params: strong_params
      expect(assigns(:flight)).to eql(flight1)
    end

    it "creates a booking associated with @flight" do
      expect{ 
        post :create, params: strong_params
      }.to change(Booking, :count).by(1)
    end

    context "with valid parameters" do
      it "redirects to the booking" do
        booking = flight1.bookings.build(strong_params[:booking])
        post :create, params: strong_params
        expect(response).to redirect_to booking_path(assigns[:booking])
      end
    end

    context "with invalid parameters" do
      it "does not create a booking" do
        expect{ 
          post :create, params: wrong_params
        }.not_to change(Booking, :count)
      end

      it "flashes warning messages" do
        post :create, params: wrong_params
        expect(flash[:danger]).to be_present
      end

      it "renders the :new template" do
        post :create, params: wrong_params
        expect(response).to render_template(:new)
      end

      it "resets @flight after rendering :new" do
        post :create, params: wrong_params
        expect(assigns(:flight)).to eql(flight1)
      end

      it "resets @number after rendering :new" do
        permitted_params = wrong_params.to_h
        
        post :create, params: wrong_params
        expect(assigns(:number)).
        to eql(permitted_params[:booking][:passengers_attributes].count)
      end
      
      

    end

  end

end
