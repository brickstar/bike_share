class TripsdashboardController < ApplicationController
  def index
    @average_duration = Trip.average_duration
  end
end
