class Station < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates_presence_of :name, :dock_count, :city, :installation_date
  before_save :generate_slug

  def generate_slug
    self.slug = name.parameterize
  end

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

  def self.newest
    order(installation_date: :asc)
  end

  def self.oldest
    order(installation_date: :asc)
  end

end
