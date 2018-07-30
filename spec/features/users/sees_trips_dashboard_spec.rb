require 'rails_helper'

describe 'visits trips dashboard' do
  before :each do
    user = User.create(first_name: 'Bob', last_name: 'Santos', street: '123 Main Street', city: 'Cranford', state: 'NJ', zip_code: '07016', email: 'Bob@gmail.com', password: 'secretsecret')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    @condition1 = Condition.create(date: Date.strptime('10/12/2015', '%m/%d/%Y'), max_temp: 71.0, mean_temp: 58.0, min_temp: 46.0, mean_humidity: 50.0, mean_visibility: 45.0 , mean_wind_speed: 41.0, precipitation: 93.0)
    @condition2 = Condition.create(date: Date.strptime('07/14/2016', '%m/%d/%Y'), max_temp: 81.0, mean_temp: 58.0, min_temp: 46.0, mean_humidity: 50.0, mean_visibility: 45.0 , mean_wind_speed: 41.0, precipitation: 93.0)
    @condition3 = Condition.create(date: Date.strptime('09/12/2016', '%m/%d/%Y'), max_temp: 91.0, mean_temp: 58.0, min_temp: 46.0, mean_humidity: 50.0, mean_visibility: 45.0 , mean_wind_speed: 41.0, precipitation: 93.0)

    @trip1 = @condition1.trips.create(duration: 120, start_date: DateTime.strptime('10/12/2015 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'Test Station 2', start_station_id: 2, end_date: DateTime.strptime('10/12/2015 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'Test Station 2', end_station_id: 2, bike_id: 2, subscription_type: 'subscriber', zip_code: '32174')
    @trip2 = @condition1.trips.create(duration: 130, start_date: DateTime.strptime('10/12/2015 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'Test Station 1', start_station_id: 1, end_date: DateTime.strptime('10/12/2015 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'Test Station 3', end_station_id: 3, bike_id: 2, subscription_type: 'customer', zip_code: '32174')
    @trip3 = @condition2.trips.create(duration: 140, start_date: DateTime.strptime('07/14/2016 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'Test Station 1', start_station_id: 1, end_date: DateTime.strptime('07/14/2016 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'Test Station 3', end_station_id: 3, bike_id: 2, subscription_type: 'customer', zip_code: '32174')
    @trip4 = @condition3.trips.create(duration: 150, start_date: DateTime.strptime('09/12/2016 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'Test Station 1', start_station_id: 1, end_date: DateTime.strptime('09/12/2016 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'Test Station 3', end_station_id: 3, bike_id: 3, subscription_type: 'customer', zip_code: '32174')

    visit trips_dashboard_path
  end

  it 'sees the average duration of a trip' do
    expected_seconds = (@trip1.duration + @trip2.duration + @trip3.duration + @trip4.duration) / 4
    expected = Time.at(expected_seconds).utc.strftime("%H:%M:%S")
    expect(page).to have_content("Average Duration: #{expected}")
  end

  it 'sees the longest trip' do
    expected = Time.at(@trip4.duration).utc.strftime("%H:%M:%S")
    expect(page).to have_content("Longest Duration: #{expected}")
  end

  it 'sees the shortest trip' do
    expected = Time.at(@trip1.duration).utc.strftime("%H:%M:%S")
    expect(page).to have_content("Shortest Duration: #{expected}")
  end

  it 'sees the station with the most rides as a starting place' do
    expected = @trip4.start_station_name
    expect(page).to have_content("Station with Most Starting Trips: #{expected}")
  end

  it 'sees the station with the most rides as an ending place' do
    expected = @trip4.end_station_name
    expect(page).to have_content("Station with Most Ending Trips: #{expected}")
  end

  it 'sees the breakdown of trips per month' do
    jan2015rides = Trip.where('extract(year  from start_date) = ? AND extract(month  from start_date) = ?', '2015', '01').count
    oct2015rides = Trip.where('extract(year  from start_date) = ? AND extract(month  from start_date) = ?', '2015', '10').count
    jul2016rides = Trip.where('extract(year  from start_date) = ? AND extract(month  from start_date) = ?', '2016', '07').count
    sept2016rides = Trip.where('extract(year  from start_date) = ? AND extract(month  from start_date) = ?', '2016', '09').count

    expect(page).to have_content("Oct 2015: #{oct2015rides} rides")
    expect(page).to have_content("Jul 2016: #{jul2016rides} rides")
    expect(page).to have_content("Sep 2016: #{sept2016rides} rides")
  end

  it 'sees the total number of trips for each year' do
    total2015rides = Trip.where('extract(year  from start_date) = ?', '2015').count
    total2016rides = Trip.where('extract(year  from start_date) = ?', '2016').count

    expect(page).to have_content("2015: #{total2015rides} rides")
    expect(page).to have_content("2016: #{total2016rides} rides")
  end

  it 'sees the most ridden bike with the number of rides for that bike' do
    expect(page).to have_content("Most Ridden Bike: ##{@trip1.bike_id} (3 rides)")
  end

  it 'sees the least ridden bike with the number of rides for that bike' do
    expect(page).to have_content("Least Ridden Bike: ##{@trip4.bike_id} (1 rides)")
  end

  it 'sees user subscription type by count and percentage' do
    expect(page).to have_content("Subscribers: #{Trip.subscribers_total} (#{Trip.subscribers_percentage.to_i}%)")
    expect(page).to have_content("Customers: #{Trip.customers_total} (#{Trip.customers_percentage.to_i}%)")
  end
  
  it 'sees user subscription type by count and percentage' do
    expect(page).to have_content("Date with the most rides: #{Trip.max_min_rides.first.date_mod} (#{Trip.max_min_rides.first.date_count} rides)")
    expect(page).to have_content("Date with the least rides: #{Trip.max_min_rides.last.date_mod} (#{Trip.max_min_rides.last.date_count} rides)")
  end
  it 'sees weather condition on day with most rides' do
    expect(page).to have_content("Weather conditions:")
    expect(page).to have_content("High Temperature: #{@condition1.max_temp}")
    expect(page).to have_content("Low Temperature: #{@condition1.min_temp}")
    expect(page).to have_content("Mean Humidity: #{@condition1.mean_humidity}")
    expect(page).to have_content("Mean Visibility: #{@condition1.mean_visibility}")
    expect(page).to have_content("Mean Wind Speed: #{@condition1.mean_wind_speed}")
    expect(page).to have_content("Precipitation: #{@condition1.precipitation}")
  end
  it 'sees weather condition on day with least rides' do
    expect(page).to have_content("Weather conditions:")
    expect(page).to have_content("High Temperature: #{@condition2.max_temp}")
    expect(page).to have_content("Low Temperature: #{@condition2.min_temp}")
    expect(page).to have_content("Mean Humidity: #{@condition2.mean_humidity}")
    expect(page).to have_content("Mean Visibility: #{@condition2.mean_visibility}")
    expect(page).to have_content("Mean Wind Speed: #{@condition2.mean_wind_speed}")
    expect(page).to have_content("Precipitation: #{@condition2.precipitation}")
  end
end
