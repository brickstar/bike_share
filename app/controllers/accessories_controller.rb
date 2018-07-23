class AccessoriesController < ApplicationController
  def index
    @accessories = Accessory.order(:price).page params[:page]
  end

  def show
    @accessory = Accessory.find(params[:id])
  end
end
