class TripsController < ApplicationController
  def index
    @trips = Trip.all.order(:id)
  end
end
