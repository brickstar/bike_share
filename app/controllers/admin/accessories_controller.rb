class Admin::AccessoriesController < Admin::BaseController

  def new
    @accessory = Accessory.new
  end

  def create
    @accessory = Accessory.new(station_params)
    if @accessory.save
      flash[:successs] = "You have successfully created #{@accessory.name}."
      redirect_to accessories_path
    else
      flash[:alert] = "Missing required fields, accessory was not created."
      render :new
    end
  end

  private

  def accessory_params
    params.require(:accessory).permit(:title, :description, :price, :image)
  end
end
