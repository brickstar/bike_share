require 'rails_helper'

describe 'visiting station show page can see a station with attributes' do
  it 'can see edit and delete buttons alongside each station' do
    admin = User.create(first_name: 'Boss',last_name: 'Lady', street: '123 Main St', city: 'Denver', state: 'CO', zip_code: '80304', email: 'Jeff@Turing.com', password: 'password', role: 1 )
    station = Station.create(name: 'San Jose City Hall', city: 'San Jose', dock_count: 15, installation_date: Date.strptime('8/6/2013', '%m/%d/%Y'))
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/#{station.name.parameterize}"

    expect(page).to have_content(station.name)
    expect(page).to have_content(station.dock_count)
    expect(page).to have_content(station.city)
    expect(page).to have_content(station.installation_date)
    expect(page).to have_button('Edit')
    expect(page).to have_button('Delete')
  end
end

describe 'can edit station and delete station from show page' do
  before :each do
    @admin = User.create(first_name: 'Boss',last_name: 'Lady', street: '123 Main St', city: 'Denver', state: 'CO', zip_code: '80304', email: 'Jeff@Turing.com', password: 'password', role: 1 )
    @station_1 = Station.create(name: 'San Jose City Hall', city: 'San Jose', dock_count: 15, installation_date: Date.strptime('8/6/2013', '%m/%d/%Y'))
  end

  it 'can delete a station' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    visit "/#{@station_1.name.parameterize}"
    click_button 'Delete'

    expect(current_path).to eq(stations_path)
    expect(page).to_not have_content('Station Name: San Jose City Hall')
    expect(page).to have_content("Successfully deleted station ##{@station_1.id}")
  end

  it 'can edit a station' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    visit "/#{@station_1.name.parameterize}"
    click_on 'Edit'

    expect(current_path).to eq(edit_admin_station_path(@station_1))
    new_station_name = 'New Test Station'
    new_station_city = 'New Test City'

    fill_in :station_name, with: new_station_name
    fill_in :station_city, with: new_station_city

    click_on 'Update Station'
    expect(current_path).to eq("/new-test-station")
    expect(page).to have_content(new_station_name)
    expect(page).to have_content(new_station_city)
    expect(page).to have_content(@station_1.dock_count)
    expect(page).to have_content("Station ##{@station_1.id} updated.")
  end
end
