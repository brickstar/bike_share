require 'rails_helper'

=begin
As a registered user,
When I visit a station show,
In addition to the user story above,
I see the Number of rides started at this station,
I see the Number of rides ended at this station,
I see the Most frequent destination station (for rides that began at this station),
I see the Most frequent origination station (for rides that ended at this station),
I see the Date with the highest number of trips started at this station,
I see the Most frequent zip code for users starting trips at this station,
I see the Bike ID most frequently starting a trip at this station.
=end

describe 'station show page' do
  it 'sees station analysis' do
    before :each do
      @station_1 = Station.create(name: 'San Jose City Hall', city: 'San Jose', dock_count: 6, installation_date: '8/6/2013')
      @station_2 = Station.create(name: 'Mountain View City Hall', city: 'Mountain View', dock_count: 5, installation_date: '8/16/2014')
      @station_3 = Station.create(name: 'Market at 10th', city: 'San Francisco', dock_count: 4, installation_date: '1/23/2016')
      @station_4 = Station.create(name: 'San Francisco City Park', city: 'San Francisco', dock_count: 6, installation_date: '8/6/2013')
      @station_5 = Station.create(name: 'Main at 2nd', city: 'San Francisco', dock_count: 6, installation_date: '8/16/2014')
      @station_6 = Station.create(name: 'Market at 28th', city: 'San Francisco', dock_count: 4, installation_date: '12/23/2015')
    end


  end
end
