class Condition < ApplicationRecord
  # has_many :trips, class_name: 'Trip', primary_key: :zip_code, foreign_key: :zip_code
  has_many :trips
  validates_presence_of :max_temp,
                        :mean_temp,
                        :min_temp,
                        :mean_humidity,
                        :mean_visibility,
                        :mean_wind_speed,
                        :precipitation

  validates :date, uniqueness: true
end
