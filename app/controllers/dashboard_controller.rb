class DashboardController < ApplicationController
  def show
    if current_user.nil?
      render file: '/public/404.html'
    end
  end
end
