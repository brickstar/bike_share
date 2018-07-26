require 'rails_helper'

describe 'visits stations show' do
  it 'should see station name url and station attributes' do
    station = Station.create!(name: "Embarcadero at Folsom",
                              dock_count: 19,
                              city: "San Francisco",
                              installation_date: "2013-08-20")

    visit "/#{station.name.parameterize}"

    expect(page).to have_content(station.name)
    expect(page).to have_content(station.dock_count)
    expect(page).to have_content(station.city)
    expect(page).to have_content(station.installation_date)
  end
end