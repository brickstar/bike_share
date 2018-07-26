require 'rails_helper'

describe 'visiting station edit page' do
  it 'can fill in a form to edit the station' do
    admin = User.create(first_name: 'Boss',last_name: 'Lady', street: '123 Main St', city: 'Denver', state: 'CO', zip_code: '80304', email: 'Jeff@Turing.com', password: 'password', role: 1 )
    station = Station.create(name: 'San Jose City Hall', city: 'San Jose', dock_count: 15, installation_date: Date.strptime('10/12/2015', '%m/%d/%Y'))

    new_station_name = 'Test Station'
    new_station_city = 'Test City'
    new_station_dock_count = '5'

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit stations_path

    click_on 'Edit'

    expect(current_path).to eq(edit_admin_station_path(station))

    fill_in :station_name, with: new_station_name
    fill_in :station_city, with: new_station_city
    fill_in :station_dock_count, with: new_station_dock_count

    click_on 'Update Station'

    expect(current_path).to eq("/test-station")
    expect(page).to have_content(new_station_name)
    expect(page).to have_content(new_station_city)
    expect(page).to have_content(new_station_dock_count)
    expect(page).to have_content("Station ##{station.id} updated.")
  end
end
