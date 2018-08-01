class Admin::OrdersController < Admin::BaseController

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(status: (params['status']))
      flash[:successs] = "Order status for #{@order.id} updated."
    else
      flash[:error] = "Unable to update status for #{@order.id}."
    end
    redirect_to admin_dashboard_path
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
