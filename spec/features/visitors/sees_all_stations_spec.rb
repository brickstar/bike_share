require 'rails_helper'

describe 'visiting the stations index' do
  it 'sees a list of all stations' do
    station_1 = Station.create(name: 'San Jose City Hall', city: 'San Jose', dock_count: 15, installation_date: Date.strptime('8/6/2013', '%m/%d/%Y'))
    station_2 = Station.create(name: 'Mountain View City Hall', city: 'Mountain View', dock_count: 17, installation_date: Date.strptime('8/16/2014', '%m/%d/%Y'))
    visit stations_path

    expect(current_path).to eq(stations_path)
    expect(page).to have_content(station_1.name)
    expect(page).to have_content(station_2.name)
    expect(page).to have_content(station_1.dock_count)
    expect(page).to have_content(station_2.dock_count)
    expect(page).to have_content(station_1.city)
    expect(page).to have_content(station_2.city)
    expect(page).to have_content(station_1.installation_date)
    expect(page).to have_content(station_2.installation_date)
    expect(page).to_not have_button('Edit')
    expect(page).to_not have_button('Delete')
  end
end
