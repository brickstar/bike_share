class Admin::DashboardController < Admin::BaseController

  def show
    @paid = Order.amount_by_status('paid')
    @completed = Order.amount_by_status('completed')
    @cancelled = Order.amount_by_status('cancelled')
    @ordered = Order.amount_by_status('ordered')
  end

end
