require 'rails_helper'

=begin
As an admin user,
When I visit admin bikeshop new
I can create an accessory,
The photo is optional. If not present, a stand-in photo is used. (PAPERCLIP)
=end

describe 'visits bike shop' do
  before :each do
    @admin = User.create(first_name: 'Jeff', last_name: 'Casimir', street: '123 Main St', city: 'Denver', state: 'Colorado', zip_code: '80403', email: 'jeff@turing.com', password: 'password', role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  it 'can create a new accessory' do
    new_accessory_title = 'Testing Setup Accessory'
    new_accessory_description = 'Testing Description'
    new_accessory_price = 10.00

    visit accessories_path
    expect(page).to have_button('Create New Accessory')

    click_button 'Create New Accessory'

    fill_in :accessory_title, with: new_accessory_title
    fill_in :accessory_description, with: new_accessory_description
    fill_in :accessory_price, with: new_accessory_price

    click_button 'Submit'

    expect(current_path).to eq(accessories_path)

    click_on 'Next'

    expect(page).to have_content(@accessory1.title)
    expect(page).to have_content(@accessory1.description)
    expect(page).to have_content(@accessory1.price)
  end
end
