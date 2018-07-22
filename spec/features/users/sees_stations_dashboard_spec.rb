require 'rails_helper'

describe 'visiting the /stations-dashboard' do
  before :each do
    station_1 = Station.create(name: 'San Jose City Hall', city: 'San Jose', dock_count: 4, installation_date: '8/6/2013')
    station_2 = Station.create(name: 'Mountain View City Hall', city: 'Mountain View', dock_count: 5, installation_date: '8/16/2014')
    station_3 = Station.create(name: 'Market at 10th', city: 'San Francisco', dock_count: 6, installation_date: '1/23/2016')
    visit stations_dashboard_path
  end

  it 'sees a total count of stations' do
    expect(page).to have_content("Total Number of Stations: #{Station.total_count}")
  end

  it 'sees average bikes available per station' do
    expect(page).to have_content("Average Bikes Available per Station: #{Station.average_bikes_per_station.round}")
  end

  it 'sees most bikes available at a station' do
    expect(page).to have_content("Inventory Level (High): #{Station.highest_bike_total}")
  end

  it 'sees fewest bikes available at a station' do
    expect(page).to have_content("Inventory Level (Low): #{Station.lowest_bike_total}")
  end

  it 'sees the station that has the most bikes available' do
    expect(page).to have_content("Highest Inventory:\nMarket at 10th")
  end

  it 'sees the station that has the fewest bikes available' do
    expect(page).to have_content("Lowest Inventory:\nSan Jose City Hall")
  end

  it 'sees the newest station' do
    expect(page).to have_content("Newest Stations:\n#{@station_3}")
  end

  it 'sees the oldest station' do
    expect(page).to have_content("Oldest Stations:\n#{@station_1}")
  end
end
