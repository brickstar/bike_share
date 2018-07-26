class StationsController < ApplicationController

  def index
    @stations = Station.all
  end

  def show
    @station = Station.friendly.find(params[:id]).includes(
                                                            @total_trips_ended = Station.total_trips_ended,
                                                            @total_trips_started = Station.total_trips_started,
                                                            @freq_destination = Station.most_riders_went_to,
                                                            @freq_origination = Station.most_riders_came_from,
                                                            @highest_volume = Station.highest_start_volume_date,
                                                            @most_users_from = Station.most_users_from_zipcode,
                                                            @most_started_bike = Station.most_started_bike_id,
                                                          )
  end
end
