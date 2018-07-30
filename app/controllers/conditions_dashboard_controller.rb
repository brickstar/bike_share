class ConditionsDashboardController < ApplicationController
  def index
    wind_ranges = Condition.wind_range
    wind_ranges.inject(Hash.new) do |acc, num|
      sequel = "conditions.mean_wind_speed >= #{num} AND conditions.mean_wind_speed < #{num + 4}"
      metrics = Trip.trip_calculator(sequel)
      acc[num] = metrics
      acc
    end
    prec = Condition.precipitation_range
    prec.inject(Hash.new) do |acc, num|
      sequel = "conditions.precipitation >= #{num} AND conditions.precipitation < #{num + 0.5}"
      metrics = Trip.trip_calculator(sequel)
      acc[num] = metrics
      acc
    end
    vis = Condition.visibility_range
    vis.inject(Hash.new) do |acc, num|
      sequel = "conditions.mean_visibility >= #{num} AND conditions.mean_visibility < #{num + 4}"
      metrics = Trip.trip_calculator(sequel)
      acc[num] = metrics
      acc
    end
    temp = Condition.max_temp_range
    temp.inject(Hash.new) do |acc, num|
      sequel = "conditions.max_temp >= #{num} AND conditions.max_temp < #{num + 10}"
      metrics = Trip.trip_calculator(sequel)
      acc[num] = metrics
      acc
    end
  end
end
