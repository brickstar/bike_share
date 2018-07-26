class Order < ApplicationRecord
  validates_presence_of :user_id, :status
  has_many :order_accessories
  belongs_to :user
end
