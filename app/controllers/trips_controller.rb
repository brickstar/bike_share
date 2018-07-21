class TripsController < ApplicationController
  def index
    @trips = Trip.all.order(:id).page params[:page]
  end
end
