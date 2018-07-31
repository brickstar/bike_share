class OrdersController < ApplicationController

  def show
    @order = Order.includes(:user).find(params[:id])
    render file: "/public/404" unless @order.user_id == current_user.id || current_admin?
  end

  def create
    order = current_user.orders.new(status: 'ordered')
      if order.save
        order.create_order_accessories(session[:cart])
        session[:cart] = nil
        flash[:success] = "Successfully submitted your order totaling #{view_context.number_to_currency(order.total)}."
        redirect_to dashboard_path
      else
        flash[:failure] = "Failed to submit your order."
        redirect_to cart_path
      end
    # end
  end
end
