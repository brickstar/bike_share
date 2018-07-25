class Admin::StationsController < Admin::BaseController
before_action :require_admin

  def index
    @stations = Station.all
  end
end
