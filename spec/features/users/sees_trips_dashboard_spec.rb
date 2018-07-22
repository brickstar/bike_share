require 'rails_helper'

describe 'visits trips dashboard' do
  before :each do
    user = User.create(first_name: 'Bob', last_name: 'Santos', street: '123 Main Street', city: 'Cranford', state: 'NJ', zip_code: '07016', email: 'Bob@gmail.com', password: 'secretsecret')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    trip1 = Trip.create(duration: 120, start_date: '12/12/2015 12:12', start_station_name: 'Test Station 1', start_station_id: 1, end_date: '12/12/2015 12:42', end_station_name: 'Test Station 2', end_station_id: 2, bike_id: 2, subscription_type: 'subscriber', zip_code: '32174')
    trip2 = Trip.create(duration: 130, start_date: '12/12/2015 12:12', start_station_name: 'Test Station 1', start_station_id: 1, end_date: '12/12/2015 12:42', end_station_name: 'Test Station 2', end_station_id: 2, bike_id: 2, subscription_type: 'customer', zip_code: '32174')
    trip3 = Trip.create(duration: 140, start_date: '12/12/2015 12:12', start_station_name: 'Test Station 2', start_station_id: 2, end_date: '12/12/2015 12:42', end_station_name: 'Test Station 2', end_station_id: 2, bike_id: 2, subscription_type: 'customer', zip_code: '32174')
    trip4 = Trip.create(duration: 150, start_date: '12/12/2015 12:12', start_station_name: 'Test Station 2', start_station_id: 2, end_date: '12/12/2015 12:42', end_station_name: 'Test Station 2', end_station_id: 2, bike_id: 2, subscription_type: 'customer', zip_code: '32174')
  end
  end
  it 'sees the average duration of a trip' do
    visit trips_dashboard_path

    expected = (trip1 + trip2 + trip3 + trip4) / 4
    expect(page).to have_content(Average Duration: expected)
  end
  it 'sees the longest trip' do

  end
  it 'sees the shortest trip' do

  end
  it 'sees the statoin with the most rides as a starting place' do

  end
  it 'sees the statoin with the most rides as an ending place' do

  end
end