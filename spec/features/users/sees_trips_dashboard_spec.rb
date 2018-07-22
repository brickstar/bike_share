require 'rails_helper'

describe 'visits trips dashboard' do
  before :each do
    user = User.create(first_name: 'Bob', last_name: 'Santos', street: '123 Main Street', city: 'Cranford', state: 'NJ', zip_code: '07016', email: 'Bob@gmail.com', password: 'secretsecret')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    @trip1 = Trip.create(duration: 120, start_date: '12/12/2015 12:12', start_station_name: 'Test Station 1', start_station_id: 1, end_date: '12/12/2015 12:42', end_station_name: 'Test Station 2', end_station_id: 2, bike_id: 2, subscription_type: 'subscriber', zip_code: '32174')
    @trip2 = Trip.create(duration: 130, start_date: '12/12/2015 12:12', start_station_name: 'Test Station 1', start_station_id: 1, end_date: '12/12/2015 12:42', end_station_name: 'Test Station 2', end_station_id: 2, bike_id: 2, subscription_type: 'customer', zip_code: '32174')
    @trip3 = Trip.create(duration: 140, start_date: '12/12/2015 12:12', start_station_name: 'Test Station 2', start_station_id: 2, end_date: '12/12/2015 12:42', end_station_name: 'Test Station 2', end_station_id: 2, bike_id: 2, subscription_type: 'customer', zip_code: '32174')
    @trip4 = Trip.create(duration: 150, start_date: '12/12/2015 12:12', start_station_name: 'Test Station 2', start_station_id: 2, end_date: '12/12/2015 12:42', end_station_name: 'Test Station 2', end_station_id: 2, bike_id: 2, subscription_type: 'customer', zip_code: '32174')
  end
  it 'sees the average duration of a trip' do
    visit trips_dashboard_path

    expected_seconds = (@trip1.duration + @trip2.duration + @trip3.duration + @trip4.duration) / 4
    expected = Time.at(expected_seconds).utc.strftime("%H:%M:%S")
    expect(page).to have_content("Average Duration: #{expected}")
  end
  it 'sees the longest trip' do
    visit trips_dashboard_path

    expected = Time.at(@trip4.duration).utc.strftime("%H:%M:%S")
    expect(page).to have_content("Longest Duration: #{expected}")
  end
  it 'sees the shortest trip' do
    visit trips_dashboard_path

    expected = Time.at(@trip1.duration).utc.strftime("%H:%M:%S")
    expect(page).to have_content("Shortest Duration: #{expected}")
  end
  it 'sees the statoin with the most rides as a starting place' do

  end
  it 'sees the statoin with the most rides as an ending place' do

  end
end