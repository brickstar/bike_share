require 'rails_helper'

describe 'admin user visits dashboard' do
  describe 'sees a list of all orders' do
    before :each do
      @admin = User.create(first_name: 'Jeff', last_name: 'Casimir', street: '123 Main St', city: 'Denver', state: 'Colorado', zip_code: '80403', email: 'jeff@turing.com', password: 'password', role: 1)
      @user_1 = User.create(first_name: 'Bob', last_name: 'Santos', street: '123 Main Street', city: 'Cranford', state: 'NJ', zip_code: '07016', email: 'Bob@gmail.com', password: 'secretsecret')
      @user_2 = User.create(first_name: 'Jeff', last_name: 'Casimir', street: '123 Market Street', city: 'Denver', state: 'CO', zip_code: '90234', email: 'Jeff@gmail.com', password: 'topsecret')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      @order_1 = @user_1.orders.create(status: 'paid')
      @accessory_1 = Accessory.create(image_url: 'https://robohash.org/1', title: 'test1', description: 'this is a test', price: 4)
      @accessory_2 = Accessory.create(image_url: 'https://robohash.org/1', title: 'test2', description: 'this is a test', price: 4)
      OrderAccessory.create(accessory_id: 1, order_id: 1, quantity: 4)
      OrderAccessory.create(accessory_id: 2, order_id: 1, quantity: 4)
      @order_2 = @user_2.orders.create(status: 'ordered')
      @accessory_3 = Accessory.create(image_url: 'https://robohash.org/1', title: 'test3', description: 'this is a test', price: 5)
      @accessory_4 = Accessory.create(image_url: 'https://robohash.org/1', title: 'test4', description: 'this is a test', price: 5)
      OrderAccessory.create(accessory_id: 3, order_id: 2, quantity: 4)
      OrderAccessory.create(accessory_id: 4, order_id: 2, quantity: 4)
      visit admin_dashboard_path
    end

    it 'total number of orders for each status' do
      expect(page).to have_content('Ordered: 1')
      expect(page).to have_content('Paid: 1')
      expect(page).to have_content('Cancelled: 0')
      expect(page).to have_content('Completed: 0')
    end

    it 'sees all order attributes and link for each individual order' do
      expect(page).to have_content(@order_1.created_at.strftime('%b %d, %Y at %I:%M%p'))
      expect(page).to have_content(@order_1.status)

      click_on '1'

      expect(current_path).to eq(order_path(@order_1))
    end

    it 'can filter orders to display by each status type' do
      expect(page).to have_link('Ordered')
      expect(page).to have_link('Paid')
      expect(page).to have_link('Cancelled')
      expect(page).to have_link('Completed')

      click_on 'Paid'
      expect(page).to have_link(@order_1.id)
      expect(page).to_not have_link(@order_2.id)
    end

    it 'can see links to transition between statuses' do
      click_link 'Ordered'
      expect(page).to_not have_link(@order_1.id)
      expect(page).to have_link(@order_2.id)
      click_button 'Back to Dashboard'
      click_link 'Paid'
      expect(page).to have_link(@order_1.id)
      expect(page).to_not have_link(@order_2.id)
      click_button 'Back to Dashboard'
      click_link 'Cancelled'
      expect(page).to_not have_link(@order_1.id)
      expect(page).to_not have_link(@order_2.id)
      click_button 'Back to Dashboard'
      click_link 'Completed'
      expect(page).to_not have_link(@order_1.id)
      expect(page).to_not have_link(@order_2.id)
      click_button 'Back to Dashboard'
    end
  end

  describe 'it can change the status of and order from the dashboard' do
    before :each do
      @admin = User.create(first_name: 'Jeff', last_name: 'Casimir', street: '123 Main St', city: 'Denver', state: 'Colorado', zip_code: '80403', email: 'jeff@turing.com', password: 'password', role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    end

    it 'can click \'cancel\' on an order that is \'paid' do
      user_1 = User.create(first_name: 'Bob', last_name: 'Santos', street: '123 Main Street', city: 'Cranford', state: 'NJ', zip_code: '07016', email: 'Bob@gmail.com', password: 'secretsecret')
      order_1 = user_1.orders.create(status: 'paid')
      accessory_1 = Accessory.create(image_url: 'https://robohash.org/1', title: 'test1', description: 'this is a test', price: 4)
      OrderAccessory.create(accessory_id: 1, order_id: 1, quantity: 4)

      visit admin_dashboard_path
      expect(page).to have_content('Paid: 1')
      expect(page).to have_content('Cancelled: 0')
      click_button 'Cancel'
      expect(page).to have_content('Paid: 0')
      expect(page).to have_content('Cancelled: 1')
    end

    it 'can click \'cancel\' an order that is \'ordered' do
      user_1 = User.create(first_name: 'Bob', last_name: 'Santos', street: '123 Main Street', city: 'Cranford', state: 'NJ', zip_code: '07016', email: 'Bob@gmail.com', password: 'secretsecret')
      order_1 = user_1.orders.create(status: 'ordered')
      accessory_1 = Accessory.create(image_url: 'https://robohash.org/1', title: 'test3', description: 'this is a test', price: 5)
      OrderAccessory.create(accessory_id: 1, order_id: 1, quantity: 4)

      visit admin_dashboard_path
      expect(page).to have_content('Ordered: 1')
      expect(page).to have_content('Cancelled: 0')
      click_button 'Cancel'
      expect(page).to have_content('Ordered: 0')
      expect(page).to have_content('Cancelled: 1')
    end

    it 'can click \'mark as completed\' on an order that is \'paid\'' do
      user_1 = User.create(first_name: 'Bob', last_name: 'Santos', street: '123 Main Street', city: 'Cranford', state: 'NJ', zip_code: '07016', email: 'Bob@gmail.com', password: 'secretsecret')
      order_1 = user_1.orders.create(status: 'paid')
      accessory_1 = Accessory.create(image_url: 'https://robohash.org/1', title: 'test1', description: 'this is a test', price: 4)
      OrderAccessory.create(accessory_id: 1, order_id: 1, quantity: 4)

      visit admin_dashboard_path
      expect(page).to have_content('Paid: 1')
      expect(page).to have_content('Completed: 0')
      click_button 'Mark as Complete'
      expect(page).to have_content('Paid: 0')
      expect(page).to have_content('Completed: 1')
    end

    it 'can click \'mark as paid\' on an order that is marked \'ordered\'' do
      user_1 = User.create(first_name: 'Bob', last_name: 'Santos', street: '123 Main Street', city: 'Cranford', state: 'NJ', zip_code: '07016', email: 'Bob@gmail.com', password: 'secretsecret')
      order_1 = user_1.orders.create(status: 'ordered')
      accessory_1 = Accessory.create(image_url: 'https://robohash.org/1', title: 'test3', description: 'this is a test', price: 5)
      OrderAccessory.create(accessory_id: 1, order_id: 1, quantity: 4)

      visit admin_dashboard_path
      expect(page).to have_content('Ordered: 1')
      expect(page).to have_content('Paid: 0')
      click_button 'Mark as Paid'
      expect(page).to have_content('Ordered: 0')
      expect(page).to have_content('Paid: 1')
    end
  end
end

describe 'admin user visits /admin/dashboard' do
  before(:each) do
    @admin = User.create(first_name: 'pearl',
                         last_name: 'girl',
                         street: '9th ave',
                         city: 'denver',
                         state: 'CO',
                         zip_code: '12345',
                         email: 'pearl@pearl.com',
                         password: 'lovelove',
                         role: 1 )
    @accessory1 = Accessory.create(image_url: 'https://robohash.org/pearl', title: 'unicycle', description: 'one wheel', price: 4, status: 1)
    @accessory2 = Accessory.create(image_url: 'https://robohash.org/heidi', title: 'tricycle', description: 'three wheels', price: 2, status: 0)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  describe 'sees a link to all accessories' do
    # it 'sees all active and inactive accessories' do
    #   visit admin_dashboard_path
    #
    #   click_on('View all Accessories')
    #
    #   expect(current_path).to eq(admin_accessories_path)
    #
    #   expect(page).to have_content(@accessory1.description)
    #   expect(page).to have_content(@accessory2.description)
    #   expect(page).to have_content(@accessory1.status)
    #   expect(page).to have_content(@accessory2.status)
    #   expect(page).to have_content(@accessory1.price)
    #   expect(page).to have_content(@accessory2.price)
    # end

    it 'can edit an accessory' do
      title = 'quinticycle'
      description = 'five wheels'
      price = 8

      visit admin_accessories_path

      within("#accessory-#{@accessory1.id}") do
        click_button('Edit')
      end

      expect(current_path).to eq(edit_admin_accessory_path(@accessory1))

      fill_in 'accessory[title]', with: title
      fill_in 'accessory[price]', with: price
      fill_in 'accessory[description]', with: description
      select 'retired', from: 'accessory[status]'

      click_on 'Submit'

      expect(current_path).to eq(admin_accessories_path)

      expect(page).to have_content(title)
      expect(page).to have_content(description)

      within("#accessory-#{@accessory1.id}") do
        expect(page).to have_content("Price: #{price}")
      end

      expect(Accessory.first.status).to eq('retired')
      expect(page).to have_content("Accessory #{title} updated.")
    end
  end
end
