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

  let! (:airports) {
    (1..4).each do |n|
      Airport.create(name: "Airport #{n}", code: "Air#{n}")
    end
  }

  let (:matching_flight) { 
    { flight: { departing_id: flight1.departing_id,
                arriving_id:  flight1.arriving_id, 
                date:         flight1.date } } }

  let (:nonmatching_flight) { 
    { flight: { departing_id: 1,
                arriving_id:  1, 
                date:         Date.new(2017, 1, 1) } } }
  
  describe "GET #index" do
    context "with params[:flight]" do
      it "assigns all the flights matching params to @flights" do
        get :index, params: matching_flight
        expect(assigns(:flights)).to match_array([flight1, flight2])
      end

      it "flashes an error when there are no matching flights" do
        get :index, params: nonmatching_flight
        expect(flash[:danger]).to be_present
      end

      it "renders the :index template" do
        get :index, params: matching_flight
        expect(response).to render_template(:index)
      end
    end

    context "without params[:flight]" do
      it "renders the :index template" do
        get :index
        expect(response).to render_template(:index)
      end
    end
  end

end
