require 'rails_helper'

describe 'registered user visits /conditions-dashboard' do
  before(:each) do
    @user = User.create(first_name: 'Pearl', last_name: 'Girl', street: '333 E 9th Ave', city: 'Denver', state: 'CO', zip_code: '12345', email: 'pearl@pearl.com', password: 'lovelove', role: 1)
    @condition_1 = Condition.create(date: 'Tue, 04 Aug 2015', max_temp: 51, mean_temp: 68, min_temp: 61, mean_humidity: 61, mean_visibility:  1, mean_wind_speed: 1, precipitation: 0.1)
    @condition_2 = Condition.create(date: 'Wed, 05 Jan 2013', max_temp: 59, mean_temp: 58, min_temp: 46, mean_humidity: 50, mean_visibility: 3, mean_wind_speed: 3, precipitation: 0.4)
    @condition_3 = Condition.create(date: 'Wed, 06 Jan 2013', max_temp: 61, mean_temp: 58, min_temp: 46, mean_humidity: 50, mean_visibility: 5, mean_wind_speed: 5, precipitation: 0.6)
    @condition_4 = Condition.create(date: 'Wed, 07 Jan 2013', max_temp: 69, mean_temp: 58, min_temp: 46, mean_humidity: 50, mean_visibility: 8, mean_wind_speed: 8, precipitation: 0.9)
    @trip_1 = @condition_1.trips.create(duration: 120, start_date: DateTime.strptime('08/04/2015 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('08/04/2015 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
    @trip_2 = @condition_2.trips.create(duration: 120, start_date: DateTime.strptime('01/05/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/05/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
    @trip_3 = @condition_2.trips.create(duration: 120, start_date: DateTime.strptime('01/05/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/05/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
    @trip_4 = @condition_2.trips.create(duration: 120, start_date: DateTime.strptime('01/05/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/05/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
    @trip_5 = @condition_3.trips.create(duration: 120, start_date: DateTime.strptime('01/06/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/06/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
    @trip_6 = @condition_4.trips.create(duration: 120, start_date: DateTime.strptime('01/07/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/07/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
    @trip_7 = @condition_4.trips.create(duration: 120, start_date: DateTime.strptime('01/07/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/07/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
    @trip_8 = @condition_4.trips.create(duration: 120, start_date: DateTime.strptime('01/07/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/07/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit conditions_dashboard_path
  end
  describe 'on days with high temperature in 10 degree chunks' do
    xit 'should see highest number of rides' do
      visit conditions_dashboard_path

      expect(page).to have_content('Highest rides by maximum temperature:')
      expect(page).to have_content('40-50: ')
      expect(page).to have_content('60-69.9: 3')
    end
    xit 'should see lowest number of rides' do
      visit conditions_dashboard_path

      expect(page).to have_content('Lowest rides by maximum temperature:')
      expect(page).to have_content('50-59.9: 1')
      expect(page).to have_content('60-69.9: 1')
    end
    xit 'should see average number of rides' do
      visit conditions_dashboard_path

      expect(page).to have_content('Average rides by maximum temperature:')
      expect(page).to have_content('50-59.9: 2')
      expect(page).to have_content('60-69.9: 2')
    end
  end
end
