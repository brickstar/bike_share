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

  def self.old_date
    maximum(:installation_date)
  end

  def self.new_date
    minimum(:installation_date)
  end

  def self.newest
    where(installation_date: new_date)
  end

  def self.oldest
    where(installation_date: old_date)
  end

end
