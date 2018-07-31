require 'rails_helper'

describe 'registered user visits /conditions-dashboard' do
  before(:each) do
    @user = User.create(first_name: 'Pearl', last_name: 'Girl', street: '333 E 9th Ave', city: 'Denver', state: 'CO', zip_code: '12345', email: 'pearl@pearl.com', password: 'lovelove', role: 0)
    @condition_1 = Condition.create!(date: 'Tue, 04 Aug 2015', max_temp: 41, mean_temp: 68, min_temp: 61, mean_humidity: 61, mean_visibility:  4, mean_wind_speed: 0, precipitation: 0.1)
    @condition_2 = Condition.create!(date: 'Wed, 05 Jan 2013', max_temp: 49, mean_temp: 58, min_temp: 46, mean_humidity: 50, mean_visibility: 4, mean_wind_speed: 2, precipitation: 0.4)
    @condition_3 = Condition.create!(date: 'Wed, 06 Jan 2013', max_temp: 51, mean_temp: 58, min_temp: 46, mean_humidity: 50, mean_visibility: 5, mean_wind_speed: 4, precipitation: 0.6)
    @condition_4 = Condition.create!(date: 'Wed, 07 Jan 2013', max_temp: 59, mean_temp: 58, min_temp: 46, mean_humidity: 50, mean_visibility: 5, mean_wind_speed: 8, precipitation: 0.9)
    @condition_5 = Condition.create!(date: 'Wed, 08 Jan 2013', max_temp: 61, mean_temp: 58, min_temp: 46, mean_humidity: 50, mean_visibility: 6, mean_wind_speed: 12, precipitation: 0.6)
    @condition_6 = Condition.create!(date: 'Wed, 09 Jan 2013', max_temp: 69, mean_temp: 58, min_temp: 46, mean_humidity: 50, mean_visibility: 6, mean_wind_speed: 12, precipitation: 0.9)
    @condition_7 = Condition.create!(date: 'Wed, 10 Jan 2013', max_temp: 71, mean_temp: 58, min_temp: 46, mean_humidity: 50, mean_visibility: 9, mean_wind_speed: 16, precipitation: 0.6)
    @condition_8 = Condition.create!(date: 'Wed, 11 Jan 2013', max_temp: 79, mean_temp: 58, min_temp: 46, mean_humidity: 50, mean_visibility: 9, mean_wind_speed: 18, precipitation: 0.9)
    @condition_9 = Condition.create!(date: 'Wed, 12 Jan 2013', max_temp: 81, mean_temp: 58, min_temp: 46, mean_humidity: 50, mean_visibility: 9, mean_wind_speed: 22, precipitation: 0.6)
    @condition_10 = Condition.create!(date: 'Wed, 13 Jan 2013', max_temp: 89, mean_temp: 58, min_temp: 46, mean_humidity: 50, mean_visibility: 9, mean_wind_speed: 22, precipitation: 0.9)
    @trip_1 = @condition_3.trips.create!(duration: 120, start_date: DateTime.strptime('08/04/2015 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('08/04/2015 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
    @trip_2 = @condition_4.trips.create!(duration: 120, start_date: DateTime.strptime('01/05/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/05/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
    @trip_3 = @condition_4.trips.create!(duration: 120, start_date: DateTime.strptime('01/05/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/05/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
    @trip_4 = @condition_4.trips.create!(duration: 120, start_date: DateTime.strptime('01/05/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/05/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
    @trip_5 = @condition_5.trips.create!(duration: 120, start_date: DateTime.strptime('01/06/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/06/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
    @trip_6 = @condition_6.trips.create!(duration: 120, start_date: DateTime.strptime('01/07/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/07/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
    @trip_7 = @condition_6.trips.create!(duration: 120, start_date: DateTime.strptime('01/07/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/07/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
    @trip_8 = @condition_6.trips.create!(duration: 120, start_date: DateTime.strptime('01/07/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/07/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')

    wind_range = Condition.wind_range
    visibility_range = Condition.visibility_range
    precipitation_range = Condition.precipitation_range
    max_temp_range = Condition.max_temp_range

    cc = ConditionCalculator.new

    @wind_data = cc.wind_data(wind_range)
    @precipitation_data = cc.precipitation_data(precipitation_range)
    @temp_data = cc.temp_data(max_temp_range)
    @visibility_data = cc.visibility_data(visibility_range)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

  end
  describe 'on days with high temperature in 10 degree chunks' do
    it 'should see highest rides' do

      visit conditions_dashboard_path

      within("#50") do
        expect(page).to have_content(@condition_1.trips.count)
        expect(page).to have_content(@condition_2.trips.count)
      end

      within("#60") do
        expect(page).to have_content(@condition_3.trips.count)
        expect(page).to have_content(@condition_4.trips.count)
      end
    end
  end
end
