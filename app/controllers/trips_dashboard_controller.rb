class TripsDashboardController < ApplicationController

  def index
    @average_duration = Trip.average_duration
    @longest_duration = Trip.longest_duration
    @shortest_duration = Trip.shortest_duration
    @station_most_starts = Trip.station_most_starts
    @station_most_ends = Trip.station_most_ends
    @breakdown_by_year = Trip.breakdown_by_year
    @breakdown_by_month = Trip.breakdown_by_month
    @most_ridden_bike = Trip.bike_id_table.first
    @least_ridden_bike = Trip.bike_id_table.last
  end
end
