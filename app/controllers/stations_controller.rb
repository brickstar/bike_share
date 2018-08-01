class StationsController < ApplicationController

  def index
    @stations = Station.order(:city, :name).page params[:page]
  end

  def show
    @station = Station.friendly.find(params[:id])
  end
end
