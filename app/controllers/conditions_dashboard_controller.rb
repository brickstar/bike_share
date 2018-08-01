class ConditionsDashboardController < ApplicationController
  def index
    wind_range = Condition.wind_range
    visibility_range = Condition.visibility_range
    precipitation_range = Condition.precipitation_range
    max_temp_range = Condition.max_temp_range

    cc = ConditionCalculator.new

    @wind_data = cc.wind_data(wind_range)
    @precipitation_data = cc.precipitation_data(precipitation_range)
    @temp_data = cc.temp_data(max_temp_range)
    @visibility_data = cc.visibility_data(visibility_range)
  end
end
