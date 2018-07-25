class Admin::StationsController < Admin::BaseController

  def new
    @station = Station.new
  end

  def create
    @station = Station.new(station_params)
    if @station.save
      flash[:successs] = "You have successfully created #{@station.name}."
      redirect_to "/#{@station.slug}"
    else
      render :new
    end
  end

  private

  def station_params
    params.require(:station).permit(:name, :city, :dock_count, :installation_date)
  end
end
