class CartsController < ApplicationController
  def create
    accessory = Accessory.find(params[:accessory_id])
    flash[:notice] = "You have added #{accessory.title} to your cart."
    redirect_to bike_shop_path
  end
end