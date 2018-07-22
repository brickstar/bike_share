require 'rails_helper'

xdescribe 'visiting the /stations-dashboard' do
  before :each do
    station_1 = Station.create(name: 'San Jose City Hall', city: 'San Jose', dock_count: 15, installation_date: 8/6/2013)
    station_2 = Station.create(name: 'Mountain View City Hall', city: 'Mountain View', dock_count: 17, installation_date: 8/16/2014)
    station_3 = Station.create(name: 'Market at 10th', city: 'San Francisco', dock_count: 27, installation_date: 1/23/2013)
  end

  xit 'sees a total count of stations' do
    expect(page).to have_content("Total Number of Stations: #{Station.total_count}")
  end

  xit 'sees average bikes available per station' do
    expect(page).to have_content("Average Bikes Available per Station: #{Station.avg_bikes_per_station}")
  end

  xit 'sees most bikes available at a station' do
    expect(page).to have_content("Most Bikes Available Count: #{Station.num_most_bikes_available}")
  end

  xit 'sees the station that has the most bikes available' do
    expect(page).to have_content("Station with Most Bikes Available: #{Station.highest_bike_count}")
  end

  xit 'sees fewest bikes available at a station' do
    expect(page).to have_content("Fewest Bikes Available Count: #{Station.num_least_bikes_available}")
  end

  xit 'sees the station that has the fewest bikes available' do
    expect(page).to have_content("Station with Fewest Bikes Available: #{Station.lowest_bike_count}")
  end

  xit 'sees the newest station' do
    expect(page).to have_content("Newest Station: #{Station.newest}")
  end

  xit 'sees the oldest station' do
    expect(page).to have_content("Oldest Station: #{Station.oldest}")
  end
end
