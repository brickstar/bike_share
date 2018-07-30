class Trip < ApplicationRecord
  # belongs_to :condition, class_name: 'Condition', foreign_key: :zip_code
  belongs_to :condition, optional: true
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

  belongs_to :start_station, class_name: 'Station', optional: true
  belongs_to :end_station, class_name: 'Station', optional: true

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

  def self.bike_id_table
    select('trips.bike_id, count(trips.bike_id) AS number_of_rides').group(:bike_id).order('number_of_rides desc')
  end

  def self.subscribers_total
    where(subscription_type: 'subscriber').count
  end

  def self.customers_total
    where(subscription_type: 'customer').count
  end

  def self.subscribers_percentage
    where(subscription_type: 'subscriber').count / Trip.count.to_f * 100
  end

  def self.customers_percentage
    where(subscription_type: 'customer').count / Trip.count.to_f * 100
  end

  def self.max_min_rides
    select('CAST(trips.start_date AS DATE) AS date_mod, count(CAST(trips.start_date AS DATE)) AS date_count').group('CAST(trips.start_date AS DATE)').order('date_count desc')
  end

  def self.trip_calculator(range)
    values = joins(:condition).where(range)
    .group(:condition_id)
    .count
    .values
    min = values.min
    max = values.max
    if values.length == 0
      avg = 0
    else
      avg = values.sum / values.length
    end
    {min: min, max: max, avg: avg.to_f}
  end
end
