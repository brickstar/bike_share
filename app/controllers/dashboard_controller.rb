class DashboardController < ApplicationController

  def index
  end

  def show
    @orders = current_user.orders
    render file: '/public/404.html' unless current_user
  end
end
