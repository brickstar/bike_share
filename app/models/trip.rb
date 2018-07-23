class Trip < ApplicationRecord
  validates_presence_of :duration,
                        :start_date,
                        :start_station_name,
                        :start_station_id,
                        :end_date,
                        :end_station_name,
                        :end_station_id,
                        :bike_id,
                        :subscription_type,
                        :zip_code
  paginates_per 30

  def self.average_duration
    average(:duration)
  end

  def self.longest_duration
    maximum(:duration)
  end

  def self.shortest_duration
    minimum(:duration)
  end

  def self.station_most_starts
    group(:start_station_name)
    .order('count_start_station_name desc')
    .limit(1)
    .count(:start_station_name)
    .keys
    .first
  end

  def self.station_most_ends
    group(:end_station_name)
    .order('count_end_station_name desc')
    .limit(1)
    .count(:end_station_name)
    .keys
    .first
  end

  def self.breakdown_by_month
    group("DATE_TRUNC('month', start_date)").count
  end

  def self.breakdown_by_year
    group("DATE_TRUNC('year', start_date)").count
  end
end
