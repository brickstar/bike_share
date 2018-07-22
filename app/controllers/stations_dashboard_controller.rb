class StationsDashboardController < ApplicationController

  def index
    @stations = Station.all
  end
end
