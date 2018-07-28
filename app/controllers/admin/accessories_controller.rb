class Admin::AccessoriesController < Admin::BaseController

  def new
    @accessory = Accessory.new
  end

  def create
    @accessory = Accessory.create(accessory_params)
    if @accessory.save
      flash[:successs] = "You have successfully created #{@accessory.title}."
      redirect_to accessory_path(@accessory)
    else
      flash[:alert] = "Missing required fields, accessory was not created."
      render :new
    end
  end

  private

  def accessory_params
    params.require(:accessory).permit(:title, :description, :price, :status, :image_url)
  end
end
