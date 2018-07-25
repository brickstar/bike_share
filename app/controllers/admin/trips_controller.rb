class Admin::TripsController < Admin::BaseController

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.create(trip_params)
    if @trip.save
      flash[:successs] = "Trip ##{@trip.id} created."
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:id])
    @trip.update(trip_params)
    if @trip.save
      flash[:success] = "Trip ##{@trip.id} updated."
      redirect_to trip_path(@trip)
    else
      render :edit
    end
  end

  def destroy
    trip = Trip.destroy(params[:id])
    flash[:success] = "Successfully deleted trip ##{trip.id}."
    redirect_to trips_path
  end

  private
  def initial_trip_params
    params.require(:trip).permit(:duration, :start_date, :start_station_name, :end_date, :end_station_name, :bike_id, :subscription_type, :zip_code)
  end
  def trip_params
    data_set = initial_trip_params
    data_set[:start_station_id] = Station.find_by_name(initial_trip_params[:start_station_name]).id.to_s
    data_set[:end_station_id] = Station.find_by_name(initial_trip_params[:end_station_name]).id.to_s
    data_set
  end
end
