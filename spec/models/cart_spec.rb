require 'rails_helper'

describe Cart do
  before :each do
    @cart = Cart.new({
      '1' => 2,
      '2' => 3
      })
  end
  describe 'instance methods' do
    it '.total_count' do
      expect(@cart.total_count).to eq(5)
    end
    it '.add_accessory' do
      @cart.add_accessory(1)
      @cart.add_accessory(2)

      expect(@cart.contents).to eq({'1' => 3, '2' => 4})
    end
    it '.unpack_contents' do
      accessory1 = Accessory.create(image_url: 'https://robohash.org/1', title: 'test1', description: 'this is a test', price: 4)
      accessory2 = Accessory.create(image_url: 'https://robohash.org/1', title: 'test2', description: 'this is a test', price: 4)
      @cart.add_accessory(1)
      @cart.add_accessory(2)

      expect(@cart.unpack_contents).to eq({accessory1 => 3, accessory2 => 4})
    end
    it '.total' do
      accessory1 = Accessory.create(image_url: 'https://robohash.org/1', title: 'test1', description: 'this is a test', price: 4)
      accessory2 = Accessory.create(image_url: 'https://robohash.org/1', title: 'test2', description: 'this is a test', price: 4)
      @cart.add_accessory(1)
      @cart.add_accessory(1)
      @cart.add_accessory(2)

      expect(@cart.total).to eq(32)
    end
    it '.remove_accessory' do
      @cart.remove_accessory('1')
      expect(@cart.contents).to eq({'2' => 3})
    end
    it '.decrease_quantity' do
      @cart.decrease_quantity('1')
      expect(@cart.contents).to eq('1' => 1, '2' => 3)
    end
  end
end
