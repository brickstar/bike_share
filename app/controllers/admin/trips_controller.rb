class Admin::TripsController < Admin::BaseController

  def destroy
    trip = Trip.destroy(params[:id])
    flash[:success] = "Successfully deleted trip ##{trip.id}."
    redirect_to trips_path
  end
end
