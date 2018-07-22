class TripsDashboardController < ApplicationController
  def index
    @average_duration = Time.at(Trip.average_duration).utc.strftime("%H:%M:%S")
    @longest_duration = Time.at(Trip.longest_duration).utc.strftime("%H:%M:%S")
    @shortest_duration = Time.at(Trip.shortest_duration).utc.strftime("%H:%M:%S")
    @station_most_starts = Trip.station_most_starts
    @station_most_ends = Trip.station_most_ends
  end
end
