class Order < ApplicationRecord
  validates_presence_of :user_id, :status
  has_many :order_accessories
  belongs_to :user

  def unpack_contents
    order_accessories.inject(Hash.new(0)) do |hash, order_accessory|
      hash[Accessory.find(order_accessory.accessory_id)] = order_accessory.quantity
      hash
    end
  end

  def total
    unpack_contents.map do |accessory, quantity|
      accessory.price * quantity
    end.sum
  end
end
