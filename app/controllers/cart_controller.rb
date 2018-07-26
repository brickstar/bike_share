class CartController < ApplicationController
  def show
  end

  def create
    accessory = Accessory.find(params[:accessory_id])
    @cart = Cart.new(session[:cart])
    @cart.add_accessory(accessory.id)
    session[:cart] = @cart.contents
    if params[:quantity] == 'one'
      redirect_to cart_path
    else
      flash[:notice] = "You have added #{accessory.title} to your cart."
      redirect_to accessories_path
    end
  end

  def destroy
    accessory = Accessory.find(params[:accessory_id])
    @cart = Cart.new(session[:cart])
    if params[:quantity] == 'one'
      @cart.decrease_quantity(accessory.id)
    else
      @cart.remove_accessory(accessory.id)
      flash[:notice] = "Successfully removed #{view_context.link_to accessory.title, accessory_path(accessory)} from your cart."
    end
    session[:cart] = @cart.contents
    redirect_to cart_path
  end
end
