class StationsController < ApplicationController
  def show
    @station = Station.friendly.find(params[:station_name])
  end
end
