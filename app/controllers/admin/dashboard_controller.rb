class Admin::DashboardController < Admin::BaseController

  def show
    @paid_status = Order.amount_by_status('paid')
    @completed_status = Order.amount_by_status('completed')
    @cancelled_status = Order.amount_by_status('cancelled')
    @ordered_status = Order.amount_by_status('ordered')
    if params[:status]
      @orders = Order.where(status: params['status'])
        render :index
    else
      @orders = Order.all
    end
  end
end
