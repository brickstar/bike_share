class StationsController < ApplicationController

  def index
    @stations = Station.all
  end


  def show
    @station = Station.friendly.find(params[:station_name])
  end
end
