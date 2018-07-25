require 'rails_helper'

describe 'station show page analysis' do
  before :each do
    @station_1 = Station.create(name: 'San Jose City Hall', city: 'San Jose', dock_count: 6, installation_date: '8/6/2013')
    @station_2 = Station.create(name: 'Mountain View City Hall', city: 'Mountain View', dock_count: 5, installation_date: '8/16/2014')
    @station_3 = Station.create(name: 'Market at 10th', city: 'San Francisco', dock_count: 4, installation_date: '1/23/2016')
    @station_4 = Station.create(name: 'San Francisco City Park', city: 'San Francisco', dock_count: 6, installation_date: '8/6/2013')
    @station_5 = Station.create(name: 'Main at 2nd', city: 'San Francisco', dock_count: 6, installation_date: '8/16/2014')
    @station_6 = Station.create(name: 'Market at 28th', city: 'San Francisco', dock_count: 4, installation_date: '12/23/2015')
  end

  it 'does not have access to admin edit and delete functionality' do
    expect(page).to_not have_button('Edit')
    expect(page).to_not have_button('Delete')
  end

  it 'can see the number of rides started here' do
  end

  it 'can see the number of rides ended here' do
  end

  xit 'can see the most frequent destination station for rides that begin here' do
  end

  xit 'can see the most frequent origination station for rides that end here' do
  end

  xit 'can see the date with the highest number of trips started here' do
  end

  xit 'can see the most frequent zip code for users starting trips here' do
  end

  xit 'can see the Bike ID that most frequently starts a trip here' do
  end
end
