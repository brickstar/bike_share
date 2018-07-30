class ConditionCalculator

  def initialize

  end

  def wind_data(range)
    range.inject(Hash.new) do |acc, num|
      sequel = "conditions.mean_wind_speed >= #{num} AND conditions.mean_wind_speed < #{num + 4}"
      metrics = Trip.trip_calculator(sequel)
      acc[num] = metrics
      acc
    end
  end

  def precipitation_data(range)
    range.inject(Hash.new) do |acc, num|
      sequel = "conditions.precipitation >= #{num} AND conditions.precipitation < #{num + 0.5}"
      metrics = Trip.trip_calculator(sequel)
      acc[num] = metrics
      acc
    end
  end

  def visibility_data(range)
    range.inject(Hash.new) do |acc, num|
      sequel = "conditions.mean_visibility >= #{num} AND conditions.mean_visibility < #{num + 4}"
      metrics = Trip.trip_calculator(sequel)
      acc[num] = metrics
      acc
    end
  end

  def temp_data(range)
    range.inject(Hash.new) do |acc, num|
      sequel = "conditions.max_temp >= #{num} AND conditions.max_temp < #{num + 10}"
      metrics = Trip.trip_calculator(sequel)
      acc[num] = metrics
      acc
    end
  end
end
