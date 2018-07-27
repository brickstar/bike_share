class Accessory < ApplicationRecord

  validates_uniqueness_of :title, presence: true
  validates_presence_of :description
  validates_numericality_of :price, greater_than: 0
  validates_presence_of :image_url, optional: true
  validates_presence_of :status

  enum status: ['retired', 'active']

  paginates_per 12
end
