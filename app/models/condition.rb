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
end
