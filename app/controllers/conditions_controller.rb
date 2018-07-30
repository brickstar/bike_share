class ConditionsController < ApplicationController

  def index
    @conditions = Condition.order(:date).page params[:page]
  end

  def show
    @condition = Condition.find(params[:id])
  end
end
