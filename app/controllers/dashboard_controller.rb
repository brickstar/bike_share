class DashboardController < ApplicationController

  def index
    
  end

  def show
    if current_user.nil?
      render file: '/public/404.html' unless current_user
    else
      @orders = current_user.orders
    end
  end
end
