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
    where(:dock_count == maximum(:dock_count)).first
  end

  def self.lowest_bike_count
    where(:dock_count == minimum(:dock_count)).first
  end


end
