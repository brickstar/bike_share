require 'rails_helper'

describe 'a user accessing the cart show page' do
  before :each do
    @user = User.create(first_name: 'Bob', last_name: 'Santos', street: '123 Main Street', city: 'Cranford', state: 'NJ', zip_code: '07016', email: 'Bob@gmail.com', password: 'secretsecret')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    @accessory1 = Accessory.create(image_url: 'https://robohash.org/1', title: 'test1', description: 'this is a test', price: 4)
    @accessory2 = Accessory.create(image_url: 'https://robohash.org/1', title: 'test2', description: 'this is a test', price: 4)
    @cart = Cart.new({
      '1' => 2,
      '2' => 3
      })
  end
  xit 'can checkout and sees a flash message with a redirect' do
    visit cart_path

    click_button 'Checkout'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Seccessfully submitted your order totalling {#{@cart.total}")
  end
end
