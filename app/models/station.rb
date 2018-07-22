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

  def self.most_bikes_total
    maximum(:dock_count)
  end

  def self.fewest_bikes_total
    minimum(:dock_count)
  end

  def self.highest_bike_count
    where(:dock_count == most_bikes_total).first
  end

  def self.lowest_bike_count
    where(:dock_count == fewest_bikes_total).last
  end

  def self.newest
    order(installation_date: :asc).first
  end

  def self.oldest
    order(installation_date: :asc).last
  end

end
