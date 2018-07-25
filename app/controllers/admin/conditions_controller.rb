class Admin::ConditionsController < Admin::BaseController

  def new
    @condition = Condition.new
  end


  def destroy
    condition = Condition.destroy(params[:id])
    flash[:success] = "Successfully deleted condition ##{condition.id}"
    redirect_to conditions_path
  end
end
