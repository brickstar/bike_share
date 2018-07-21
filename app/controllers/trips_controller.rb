class TripsController < ApplicationController
  def index
    @trips = Trip.order(:start_date).page params[:page]
  end
end
