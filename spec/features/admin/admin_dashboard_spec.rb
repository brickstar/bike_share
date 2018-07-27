require 'rails_helper'

describe 'admin user visits dashboard' do
  describe 'sees a list of all orders' do
    before :each do
      @admin = User.create(first_name: 'Jeff', last_name: 'Casimir', street: '123 Main St', city: 'Denver', state: 'Colorado', zip_code: '80403', email: 'jeff@turing.com', password: 'password', role: 1)
      @user_1 = User.create(first_name: 'Bob', last_name: 'Santos', street: '123 Main Street', city: 'Cranford', state: 'NJ', zip_code: '07016', email: 'Bob@gmail.com', password: 'secretsecret')
      @user_2 = User.create(first_name: 'Jeff', last_name: 'Casimir', street: '123 Market Street', city: 'Denver', state: 'CO', zip_code: '90234', email: 'Jeff@gmail.com', password: 'topsecret')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      @order_1 = @user_1.orders.create(status: 'paid')
      @accessory_1 = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test1', description: 'this is a test', price: 4)
      @accessory_2 = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test2', description: 'this is a test', price: 4)
      OrderAccessory.create(accessory_id: 1, order_id: 1, quantity: 4)
      OrderAccessory.create(accessory_id: 2, order_id: 1, quantity: 4)

      @order_2 = @user_2.orders.create(status: 'ordered')
      @accessory_3 = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test3', description: 'this is a test', price: 5)
      @accessory_4 = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test4', description: 'this is a test', price: 5)
      OrderAccessory.create(accessory_id: 3, order_id: 2, quantity: 4)
      OrderAccessory.create(accessory_id: 4, order_id: 2, quantity: 4)
      visit admin_dashboard_path(@admin)

    end

    it 'total number of orders for each status' do
      expect(page).to have_content('Ordered: 1')
      expect(page).to have_content('Paid: 1')
      expect(page).to have_content('Cancelled: 0')
      expect(page).to have_content('Completed: 0')
    end

    it 'sees link for each individual order' do
      click_on '1'
      expect(current_path).to eq(order_path(@order_1))
    end

    xit 'can filter orders to display by each status type' do

      expect(page).to have_content('Ordered')
      expect(page).to have_content('Paid')
      expect(page).to have_content('Cancelled')
      expect(page).to have_content('Completed')
    end

    xit 'can see links to transxition between statuses' do
    end

    xit 'can click \'cancel\' on an order that is \'paid or ordered\'' do
    end

    xit 'can click \'mark as paid\' on an order that is marked \'ordered\'' do
    end

    xit 'can click \'mark as completed\' on an order that is \'paid\'' do
    end
  end
end
