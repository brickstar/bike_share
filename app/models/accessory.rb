class Accessory < ApplicationRecord
  validates_presence_of :image_url, :title, :description, :price, :status
  enum status: ['retired', 'active']
end
