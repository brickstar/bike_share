class Admin::DashboardController < Admin::BaseController

  def show
    @user = User.find(current_user.id)
  end

end
