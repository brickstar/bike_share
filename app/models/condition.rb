class Condition < ApplicationRecord
  # has_many :trips, class_name: 'Trip', primary_key: :zip_code, foreign_key: :zip_code
  has_many :trips
  validates_presence_of :max_temp,
  :mean_temp,
  :min_temp,
  :mean_humidity,
  :mean_visibility,
  :mean_wind_speed,
  :precipitation,
  :date

  validates :date, uniqueness: true

  def self.within_max_temp_range(low, high)
    where(max_temp: low..high)
  end

  def self.trips_per_day
    joins(:trips)
    .group(:condition_id)
    .count.values
  end

  def self.most_rides
    find_by(date: Trip.max_min_rides.first.date_mod)
  end

  def self.least_rides
    find_by(date: Trip.max_min_rides.last.date_mod)
  end

  def self.float_range_finder(step, min, max)
    min = (min * 2).floor / 2.to_f
    max = (max * 2).ceil / 2.to_f
    thing = (min..max).step(step).to_a
  end

  def self.precipitation_range
    min = minimum(:precipitation)
    max = maximum(:precipitation)
    float_range_finder(0.5, min, max)
  end

  def self.max_temp_range
    min = minimum(:max_temp).floor(-1)
    max = maximum(:max_temp).ceil(-1)
    integer_range_finder(10, min, max)
  end

  def self.visibility_range
    min = minimum(:mean_visibility)
    max = maximum(:mean_visibility)
    integer_range_finder(4, min, max)
  end

  def self.wind_range
    min = minimum(:mean_wind_speed)
    max = maximum(:mean_wind_speed)
    integer_range_finder(4, min, max)
  end

  def self.integer_range_finder(step, min, max)
    remainder = max % step
    max = max + (step - remainder) if remainder != 0
    (min..max).step(step).to_a
  end

  def self.temp_all_rides
    temp_ranges.map do |r|
      joins(:trips)
      .where("max_temp >= #{r[0]} AND max_temp <= #{r[1]}")
      .group(:condition_id)
      .count(:condition_id)
      .values
    end
  end

  def self.mean_wind_speed_ranges
    range = []
    min = minimum(:mean_wind_speed)
    max = maximum(:mean_wind_speed)
    until min >= max
      range << [min, (min + 3.9)]
      min += 4
    end
    range
  end

  def self.mean_visibility_ranges
    range = []
    min = minimum(:mean_visibility)
    max = maximum(:mean_visibility)
    until min >= max
      range << [min, (min + 3.9)]
      min += 4
    end
    range
  end
end
