class Accessory < ApplicationRecord

  has_many :order_accessories
  has_many :orders, through: :order_accessories

  validates_uniqueness_of :title, presence: true
  validates_presence_of :description
  validates_numericality_of :price, greater_than: 0
  validates_presence_of :status

  enum status: ['retired', 'active']

  paginates_per 12
end
