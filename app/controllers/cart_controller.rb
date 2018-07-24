class CartController < ApplicationController
  def show
    
  end
  
  def create
    accessory = Accessory.find(params[:accessory_id])
    @cart = Cart.new(session[:cart])
    @cart.add_accessory(accessory.id)
    session[:cart] = @cart.contents
    
    flash[:notice] = "You have added #{accessory.title} to your cart."
    redirect_to accessory_path(accessory)
  end
end
