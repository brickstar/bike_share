class Admin::AccessoriesController < Admin::BaseController

  def index
    @accessories = Accessory.order(:price)
  end

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

  def edit
    @accessory = Accessory.find(params[:id])
  end

  def update
    @accessory = Accessory.find(params[:id])
    if params[:status]
      @accessory.update(status: params[:status])
    else
      @accessory.update(accessory_params)
    end
    if @accessory.save
      flash[:success] = "Accessory #{@accessory.title} updated."
      redirect_to admin_accessories_path
    else
      render :edit
    end
  end

  private

  def initial_accessory_params
    params.require(:accessory).permit(:title, :description, :price, :status, :image_url)
  end

  def accessory_params
    if initial_accessory_params[:image_url].empty?
      data_set = initial_accessory_params
      data_set[:image_url] = "https://robohash.org/1"
      data_set
    else
      initial_accessory_params
    end
  end
end
