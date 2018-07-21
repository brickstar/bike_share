require 'rails_helper'

describe 'visiting trips index' do
  it 'sees 30 trips per page' do
    45.times do |index|
      Trip.create(duration: index, start_date: '12/12/2015 12:12', start_station_name: 'Test Station 1', start_station_id: 1, end_date: '12/12/2015 12:42', end_station_name: 'Test Station 2', end_station_id: 2, bike_id: 2, subscription_type: 'customer', zip_code: '32174')
    end

    visit trips_path

    expect(page).to have_content('All Trips')
    expect(page).to have_content("Duration: #{Trip.first.duration}s")
    expect(page).to have_content("Duration: #{Trip.find(30).duration}s")
    expect(page).to_not have_content("Duration: #{Trip.find(31).duration}s")
  end
end
