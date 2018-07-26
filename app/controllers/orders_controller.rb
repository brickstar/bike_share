class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def create
    order = current_user.orders.create(status: 'ordered')
    
    redirect_to dashboard_path
  end
end
