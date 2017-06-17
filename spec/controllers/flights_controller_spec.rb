require 'rails_helper'

RSpec.describe FlightsController, type: :controller do
  let (:flight1) { Flight.create(
    departing_id: '1',
    arriving_id: '2',
    date: Date.new(2017, 6, 14),
    duration: 250_000
  )}

  let (:flight2) { Flight.create(
    departing_id: '1',
    arriving_id: '2',
    date: Date.new(2017, 6, 14),
    duration: 255_000
  )}

  let (:flight3) { Flight.create(
    departing_id: '3',
    arriving_id: '4',
    date: Date.new(2017, 6, 14),
    duration: 255_000
  )}

  let (:flight_params) { { flight: { departing_id: flight1.departing_id,
                                   arriving_id:  flight1.arriving_id, 
                                   date:         flight1.date } } }

  describe "GET #index" do
    context "with params[:flight]" do
      it "assigns all flights matching params to @chosen_flights" do
        get :index, params: flight_params

        expect(assigns(:chosen_flights)).to match_array([flight1, flight2])
      end

      it "renders the :index template" do
        get :index, params: flight_params
        expect(response).to render_template(:index)
      end
    end
  end

end
