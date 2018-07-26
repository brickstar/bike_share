require 'rails_helper'

describe 'visits stations show' do
  before :each do
    @station = Station.create!(name: "Embarcadero at Folsom",
                              dock_count: 19,
                              city: "San Francisco",
                              installation_date: Date.strptime('8/20/2013', '%m/%d/%Y'))

    visit "/#{@station.name.parameterize}"
  end

  it 'can see station name url and station attributes' do
    expect(page).to have_content(@station.name)
    expect(page).to have_content(@station.dock_count)
    expect(page).to have_content(@station.city)
    expect(page).to have_content(@station.installation_date)
  end

  it 'cannot see specific station information meant for users' do
    expect(page).to_not have_content('Number of rides started at this station:')
    expect(page).to_not have_content('Number of rides ended at this station:' )
    expect(page).to_not have_content('Most frequent destination station:' )
    expect(page).to_not have_content('Most frequent origination station:' )
    expect(page).to_not have_content('Date with the highest number of trips started at this station:' )
    expect(page).to_not have_content('Most frequent zip code for users starting trips at this station:')
    expect(page).to_not have_content('Bike ID most frequently starting a trip at this station:') 
  end
end
