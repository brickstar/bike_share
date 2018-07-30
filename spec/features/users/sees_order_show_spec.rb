require 'rails_helper'

describe 'a user accessing the cart show page' do
  before :each do
    user = User.create(first_name: 'Bob', last_name: 'Santos', street: '123 Main Street', city: 'Cranford', state: 'NJ', zip_code: '07016', email: 'Bob@gmail.com', password: 'secretsecret')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    @accessory1 = Accessory.create(image_url: 'https://robohash.org/1', title: 'test1', description: 'this is a test', price: 4)
    @accessory2 = Accessory.create(image_url: 'https://robohash.org/1', title: 'test2', description: 'this is a test', price: 4)
    @order1 = user.orders.create(status: 'ordered')
    @order2 = user.orders.create(status: 'paid')
    @order2.created_at = 'Weds 24 Jul 2018'
    OrderAccessory.create(order_id: @order1.id, accessory_id: @accessory1.id, quantity: 2)
    OrderAccessory.create(order_id: @order1.id, accessory_id: @accessory2.id, quantity: 3)
    OrderAccessory.create(order_id: @order2.id, accessory_id: @accessory2.id, quantity: 1)
  end

  it 'can view order attributes' do
    visit dashboard_path

    click_on (@order1.created_at.strftime('%Y-%m-%d'))

    expect(current_path).to eq(order_path(@order1))
    expect(page).to have_content(@accessory1.title)
    expect(page).to have_content(@accessory2.title)
    expect(page).to have_content("\nItem Title Price Quantity Sub-Total")
    expect(page).to have_content("test1 $4.00 2 $8.00 test2 $4.00 3 $12.00\n")
    expect(page).to have_content("Submitted: #{@order1.created_at.strftime('%m/%d/%y at %l:%M %p')}")
    expect(page).to have_content("Status Changed: #{@order1.updated_at.strftime('%m/%d/%y at %l:%M %p')}")
  end
end
