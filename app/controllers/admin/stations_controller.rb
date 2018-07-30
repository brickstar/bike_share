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
      flash[:alert] = "Missing required fields, station was not created."
      render :new
    end
  end

  def edit
    @station = Station.friendly.find(params[:id])
  end

  def update
    @station = Station.friendly.find(params[:id])
    @station.update(station_params)
    @station.slug = @station.name.parameterize
     if @station.save
       flash[:success] = "Station ##{@station.id} updated."
       redirect_to "/#{@station.slug}"
     else
       render :edit
     end
  end

  def destroy
    station = Station.friendly.find(params[:id])
    station.destroy
    flash[:success] = "Successfully deleted station ##{station.id}"
    redirect_to stations_path
  end

  private

  def station_params
    params.require(:station).permit(:name, :city, :dock_count, :installation_date)
  end
end
