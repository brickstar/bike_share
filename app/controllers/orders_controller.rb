class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def create
    order = current_user.orders.create(status: 'ordered')
    if order.save
      order.create_order_accessories(session[:cart])
      flash[:success] = "Successfully submitted your order totaling $#{order.total}."
      redirect_to dashboard_path
    else
      flash[:failure] = "Failed to submit your order."
      redirect_to cart_path
    end

  end
end
