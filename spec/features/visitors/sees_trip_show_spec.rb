require 'rails_helper'

describe 'visiting the trip show page' do
  it 'sees all attributes for the single trip' do
    trip = Trip.create(duration: 400, start_date: '12/12/2015 12:12', start_station_name: 'Test Station 1', start_station_id: 1, end_date: '12/12/2015 12:42', end_station_name: 'Test Station 2', end_station_id: 2, bike_id: 2, subscription_type: 'customer', zip_code: '32174')

    visit trip_path(trip)

    expect(page).to have_content(trip.id)
    expect(page).to have_content(trip.duration)
    expect(page).to have_content(trip.start_date)
    expect(page).to have_content(trip.start_station_name)
    expect(page).to have_content(trip.end_date)
    expect(page).to have_content(trip.end_station_name)
    expect(page).to have_content(trip.subscription_type)
    expect(page).to have_content(trip.zip_code)
  end
end
