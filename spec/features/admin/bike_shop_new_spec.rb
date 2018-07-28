require 'rails_helper'

describe 'visits bike shop' do
  before :each do
    @admin = User.create(first_name: 'Jeff', last_name: 'Casimir', street: '123 Main St', city: 'Denver', state: 'Colorado', zip_code: '80403', email: 'jeff@turing.com', password: 'password', role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  it 'can create a new accessory' do
    new_accessory_title = 'Testing Setup Accessory'
    new_accessory_description = 'Testing Description'
    new_accessory_price = 10.00
    new_image_url = "https://robohash.org/1"
    new_status = 'active'

    visit accessories_path

    expect(page).to have_button('Create New Accessory')

    click_button 'Create New Accessory'

    fill_in :accessory_title, with: new_accessory_title
    fill_in :accessory_description, with: new_accessory_description
    fill_in :accessory_price, with: new_accessory_price
    fill_in :accessory_image_url, with: new_image_url
    select new_status, from: 'accessory[status]'

    click_button 'Create Accessory'

    expect(current_path).to eq(accessory_path(Accessory.last))

    expect(page).to have_content(new_accessory_title)
    expect(page).to have_content(new_accessory_description)
    expect(page).to have_content(new_accessory_price)
    expect(page).to have_content(new_status)
  end
end
