require 'rails_helper'

describe Order, type: :model do
  describe "validations" do
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:user_id) }
  end

  describe "relationships" do
    it { should belong_to(:user) }
    it { should have_many(:order_accessories) }
    it { should have_many(:accessories).through(:order_accessories) }
  end

  describe 'instance method' do
    before :each do
      user = User.create(first_name: 'Bob', last_name: 'Santos', street: '123 Main Street', city: 'Cranford', state: 'NJ', zip_code: '07016', email: 'Bob@gmail.com', password: 'secretsecret')
      @order = user.orders.create(status: 'paid')
      @accessory1 = Accessory.create(image_url: 'https://robohash.org/1', title: 'test1', description: 'this is a test', price: 4)
      @accessory2 = Accessory.create(image_url: 'https://robohash.org/1', title: 'test2', description: 'this is a test', price: 4)
      OrderAccessory.create(accessory_id: 1, order_id: 1, quantity: 2)
      OrderAccessory.create(accessory_id: 2, order_id: 1, quantity: 3)
    end

    it '.unpack_contents' do
      expect(@order.unpack_contents).to eq({@accessory1 => 2, @accessory2 => 3})
    end

    it '.total' do
      expect(@order.total).to eq(20)
    end
  end

  describe 'class methods' do
    before :each do
      user = User.create(first_name: 'Bob', last_name: 'Santos', street: '123 Main Street', city: 'Cranford', state: 'NJ', zip_code: '07016', email: 'Bob@gmail.com', password: 'secretsecret')
      order_1 = user.orders.create(status: 'paid')
      order_2 = user.orders.create(status: 'cancelled')
      order_3 = user.orders.create(status: 'ordered')
      order_4 = user.orders.create(status: 'completed')
      order_5 = user.orders.create(status: 'completed')
      order_6 = user.orders.create(status: 'paid')
    end

    it '#amount_by_status(status)' do
      expect(Order.amount_by_status('paid')).to eq(2)
      expect(Order.amount_by_status('ordered')).to eq(1)
      expect(Order.amount_by_status('completed')).to eq(2)
      expect(Order.amount_by_status('cancelled')).to eq(1)
    end
  end
end
