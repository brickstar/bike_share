class Accessory < ApplicationRecord
  validates_presence_of :image_url, :title, :description, :price, :status
  has_many :order_accessories
  enum status: ['retired', 'active']
  paginates_per 12
end
