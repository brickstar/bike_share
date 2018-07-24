class Condition < ApplicationRecord
  has_many :trips, class_name: 'Trip', primary_key: :date, foreign_key: :start_date
  validates_presence_of :max_temp,
                        :mean_temp,
                        :min_temp,
                        :mean_humidity,
                        :mean_visibility,
                        :mean_wind_speed,
                        :precipitation,
                        :date
  validates :date, uniqueness: true
end
