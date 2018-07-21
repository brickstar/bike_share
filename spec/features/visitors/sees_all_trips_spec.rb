require 'rails_helper'

=begin
When I visit the trips index,
I see the first 30 trips (duration, start date, start station, end date, end station, bike id, subscription type, zip code)
=end

describe 'visiting trips index' do
  it 'sees 30 trips per page' do
    45.times.with_index do |index|
      Trip.create!(duration: index, start_date: '12/12/2015 12:12', start_station_name: 'Test Station 1', start_station_id: 1, end_date: '12/12/2015 12:42', end_station_name: 'Test Station 2', end_station_id: 2, bike_id: 2, subscription_type: 'customer', zip_code: '32174')
    end

    visit trips_path

    expect(page).to have_content('All Trips')
    expect(page).to have_content("Duration: #{Trip[0].index}s")
    expect(page).to have_content("Duration: #{Trip[29].index}s")
    expect(page).to_not have_content("Duration: #{Trip[30].index}s")
  end
end
