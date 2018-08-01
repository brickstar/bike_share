class TripsController < ApplicationController

  def index
    @trips = Trip.order(:id).page params[:page]
  end

  def show
    @trip = Trip.find(params[:id])
  end
end
