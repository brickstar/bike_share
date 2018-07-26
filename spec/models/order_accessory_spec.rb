require 'rails_helper'

describe OrderAccessory, type: :model do
  describe "validations" do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:order_id) }
    it { should validate_presence_of(:accessory_id) }
  end

  describe "relationships" do
    it { should belong_to(:order) }
    it { should belong_to(:accessory) }
  end

  describe 'instance methods' do
    it 'create_order_accessories' do
      user = User.create(first_name: 'Bob', last_name: 'Santos', street: '123 Main Street', city: 'Cranford', state: 'NJ', zip_code: '07016', email: 'Bob@gmail.com', password: 'secretsecret')
      @order = user.orders.create(status: 'paid')
      @accessory1 = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test1', description: 'this is a test', price: 4)
      @accessory2 = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test2', description: 'this is a test', price: 7)

      cart = {'1' => 2, '2' => 4}
      
      @order.create_order_accessories(cart)

      expect(OrderAccessory.first.quantity).to eq(2)
      expect(OrderAccessory.first.accessory.price).to eq(4)
      expect(OrderAccessory.last.quantity).to eq(4)
      expect(OrderAccessory.last.accessory.price).to eq(7)
    end
  end
end
