require 'rails_helper'

describe 'a user accessing the cart show page' do
  before :each do
    @user = User.create(first_name: 'Bob', last_name: 'Santos', street: '123 Main Street', city: 'Cranford', state: 'NJ', zip_code: '07016', email: 'Bob@gmail.com', password: 'secretsecret')
    @accessory1 = Accessory.create(image_url: 'https://robohash.org/1', title: 'test1', description: 'this is a test', price: 4)
    @accessory2 = Accessory.create(image_url: 'https://robohash.org/1', title: 'test2', description: 'this is a test', price: 4)
    @order1 = @user.orders.create(status: 'ordered')
    @order2 = @user.orders.create(status: 'paid')
    @order2.created_at = 'Weds 24 Jul 2018'
    OrderAccessory.create(order_id: @order1.id, accessory_id: @accessory1.id, quantity: 2)
    OrderAccessory.create(order_id: @order1.id, accessory_id: @accessory2.id, quantity: 3)
    OrderAccessory.create(order_id: @order2.id, accessory_id: @accessory2.id, quantity: 1)
    @admin = User.create(first_name: 'Admin', last_name: 'Santos', street: '123 Main Street', city: 'Cranford', state: 'NJ', zip_code: '07016', email: 'Bob@gmail.com', password: 'secretsecret', role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end
  it 'can view order attributes along with additional admin only information' do
    visit order_path(@order1)

    expect(page).to have_content(@accessory1.title)
    expect(page).to have_content('Quantity: 2')
    expect(page).to have_content('Subtotal: $8.00')
    expect(page).to have_content(@accessory2.title)
    expect(page).to have_content('Quantity: 3')
    expect(page).to have_content('Subtotal: $12.00')
    expect(page).to have_content('Total: $20.00')
    expect(page).to have_content("Status: #{@order1.status}")
    expect(page).to have_content("Submitted: #{@order1.created_at.strftime("%d %b %Y %H:%M")}")
    expect(page).to have_content("Status Changed: #{@order1.updated_at.strftime("%d %b %Y %H:%M")}")
    expect(page).to have_content("Customer Name: #{@user.first_name} #{@user.last_name}")
    expect(page).to have_content("Customer Address: #{@user.street} #{@user.city}, #{@user.state} #{@user.zip_code}")

    click_on @accessory1.title

    expect(current_path).to eq(accessory_path(@accessory1))
  end
end
