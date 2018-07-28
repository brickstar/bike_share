class DashboardController < ApplicationController
  
  def show
    @orders = current_user.orders
    render file: '/public/404.html' unless current_user
  end
end
