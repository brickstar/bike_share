class StationsDashboardController < ApplicationController

  def index
    @stations_total_count = Station.total_count
    @stations_average_bikes = Station.average_bikes_per_station
    @stations_highest_bike_total = Station.highest_bike_total
    @stations_lowest_bike_total = Station.lowest_bike_total
    @stations_with_highest_inventory = Station.with_highest_inventory
    @stations_with_lowest_inventory = Station.with_lowest_inventory
    @newest_stations = Station.newest
    @oldest_stations = Station.oldest
  end
end
