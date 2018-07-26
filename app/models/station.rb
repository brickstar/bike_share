class Station < ApplicationRecord
  extend FriendlyId

  has_many :start_trips, class_name: 'Trip', foreign_key: :start_station_id
  has_many :end_trips, class_name: 'Trip', foreign_key: :end_station_id

  friendly_id :name, use: :slugged
  validates_presence_of :name, :dock_count, :city, :installation_date

  def self.total_count
    count
  end

  def self.average_bikes_per_station
    average(:dock_count)
  end

  def self.highest_bike_total
    maximum(:dock_count)
  end

  def self.lowest_bike_total
    minimum(:dock_count)
  end

  def self.with_highest_inventory
    where(dock_count: highest_bike_total)
  end

  def self.with_lowest_inventory
    where(dock_count: lowest_bike_total)
  end

  def self.old_date
    minimum(:installation_date)
  end

  def self.new_date
    maximum(:installation_date)
  end

  def self.newest
    where(installation_date: new_date)
  end

  def self.oldest
    where(installation_date: old_date)
  end

  def total_trips_ended
    end_trips.count
  end

  def total_trips_started
    start_trips.count
  end

  def most_riders_went_to
    start_trips.select('end_station_name, count(end_station_name) as count_per_end')
    .group(:end_station_name)
    .order('count_per_end')
    .last
    .end_station_name
  end

  def most_riders_came_from
    end_trips.select('start_station_name, count(start_station_name) as count_per_start')
    .group(:start_station_name)
    .order('count_per_start')
    .last
    .start_station_name
  end


  def highest_start_volume_date
    start_trips.select('start_date, count(start_date) as count_per_date')
    .group(:start_date)
    .order('count_per_date')
    .last
    .start_date
    .to_date
  end

  def most_users_from_zipcode
    start_trips.select('zip_code, count(zip_code) as count_per_zip_code')
    .group(:zip_code)
    .order('count_per_zip_code')
    .last
    .zip_code
  end

  def most_started_bike_id
    start_trips.select('bike_id, count(bike_id) as count_per_bike_id')
    .group(:bike_id)
    .order('count_per_bike_id')
    .last
    .bike_id
  end
end
