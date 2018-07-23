require 'rails_helper'

describe 'visits trips dashboard' do
  before :each do
    user = User.create(first_name: 'Bob', last_name: 'Santos', street: '123 Main Street', city: 'Cranford', state: 'NJ', zip_code: '07016', email: 'Bob@gmail.com', password: 'secretsecret')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    @trip1 = Trip.create!(duration: 120, start_date: DateTime.strptime('10/12/2015 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'Test Station 2', start_station_id: 2, end_date: DateTime.strptime('10/12/2015 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'Test Station 2', end_station_id: 2, bike_id: 2, subscription_type: 'subscriber', zip_code: '32174')
    @trip2 = Trip.create!(duration: 130, start_date: DateTime.strptime('10/13/2015 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'Test Station 1', start_station_id: 1, end_date: DateTime.strptime('10/13/2015 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'Test Station 3', end_station_id: 3, bike_id: 2, subscription_type: 'customer', zip_code: '32174')
    @trip3 = Trip.create!(duration: 140, start_date: DateTime.strptime('07/14/2016 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'Test Station 1', start_station_id: 1, end_date: DateTime.strptime('07/14/2016 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'Test Station 3', end_station_id: 3, bike_id: 2, subscription_type: 'customer', zip_code: '32174')
    @trip4 = Trip.create!(duration: 150, start_date: DateTime.strptime('09/12/2016 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'Test Station 1', start_station_id: 1, end_date: DateTime.strptime('09/12/2016 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'Test Station 3', end_station_id: 3, bike_id: 2, subscription_type: 'customer', zip_code: '32174')
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
  it 'sees the station with the most rides as a starting place' do
    visit trips_dashboard_path

    expected = @trip4.start_station_name
    expect(page).to have_content("Station with Most Starting Trips: #{expected}")
  end
  it 'sees the station with the most rides as an ending place' do
    visit trips_dashboard_path

    expected = @trip4.end_station_name
    expect(page).to have_content("Station with Most Ending Trips: #{expected}")
  end
  it 'sees the breakdown of trips per month for each year' do
    visit trips_dashboard_path

    total2015rides = Trip.where('extract(year  from start_date) = ?', '2015').count
    jan2015rides = Trip.where('extract(year  from start_date) = ? AND extract(month  from start_date) = ?', '2015', '01').count
    oct2015rides = Trip.where('extract(year  from start_date) = ? AND extract(month  from start_date) = ?', '2015', '10').count
    total2016rides = Trip.where('extract(year  from start_date) = ?', '2016').count
    jul2016rides = Trip.where('extract(year  from start_date) = ? AND extract(month  from start_date) = ?', '2016', '07').count
    sept2016rides = Trip.where('extract(year  from start_date) = ? AND extract(month  from start_date) = ?', '2016', '09').count
    r
    expect(page).to have_content("Breakdown of Rides per Month for each Year:")
    expect(page).to have_content("#{@trip1.start_date.year} (#{total2015rides} Total Rides):")
    expect(page).to have_content("January: #{jan2015rides}")
    expect(page).to have_content("October: #{oct2015rides}")
    expect(page).to have_content("#{@trip4.start_date.year} (#{total2016rides} Total Rides):")
    expect(page).to have_content("July: #{jul2016rides}")
    expect(page).to have_content("September: #{sept2016rides}")
  end
  it 'sees the total number of trips for each year' do
    visit trips_dashboard_path


  end
end
