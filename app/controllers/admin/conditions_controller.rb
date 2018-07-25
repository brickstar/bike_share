class Admin::ConditionsController < Admin::BaseController

  def destroy
    condition = Condition.destroy(params[:id])
    flash[:success] = "Successfully deleted condition ##{condition.id}"
    redirect_to conditions_path
  end
end
