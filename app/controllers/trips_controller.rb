class TripsController < ApplicationController
  def index
    @trips = Trip.order(:id).page params[:page]
  end
end
