require 'rails_helper'

describe 'visiting station new page' do
  before :each do
    @admin = User.create(first_name: 'Boss',last_name: 'Lady', street: '123 Main St', city: 'Denver', state: 'CO', zip_code: '80304', email: 'Jeff@Turing.com', password: 'password', role: 1 )
  end

  it 'can fill in a form to create a new station' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    station_name = 'Test Station'
    station_city = 'Test City'
    station_dock_count = '5'
    station_install_date = '8/6/2013'

    visit new_admin_station_path

    fill_in :station_name, with: station_name
    fill_in :station_city, with: station_city
    fill_in :station_dock_count, with: station_dock_count
    fill_in :station_installation_date, with: station_install_date

    click_on 'Create Station'

    expect(current_path).to eq("/#{station_name.parameterize}")
    expect(page).to have_content(station_name)
    expect(page).to have_content(station_city)
    expect(page).to have_content(station_dock_count)
    expect(page).to have_content(station_install_date)
    expect(page).to have_content("You have successfully created #{station_name}.")
  end
end