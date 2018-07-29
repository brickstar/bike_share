require 'rails_helper'

describe Condition, type: :model do
  describe "validations" do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:max_temp) }
    it { should validate_presence_of(:mean_temp) }
    it { should validate_presence_of(:min_temp) }
    it { should validate_presence_of(:mean_humidity) }
    it { should validate_presence_of(:mean_visibility) }
    it { should validate_presence_of(:mean_wind_speed) }
    it { should validate_presence_of(:precipitation) }
  end

  describe 'class methods' do
    before(:each) do
      @condition_1 = Condition.create!(date: 'Tue, 04 Aug 2015', max_temp: 52, mean_temp: 68, min_temp: 61, mean_humidity: 61, mean_visibility:  1, mean_wind_speed: 1, precipitation: 0.1)
      @condition_2 = Condition.create!(date: 'Wed, 05 Jan 2013', max_temp: 59, mean_temp: 58, min_temp: 46, mean_humidity: 50, mean_visibility: 3, mean_wind_speed: 3, precipitation: 0.4)
      @condition_3 = Condition.create!(date: 'Wed, 06 Jan 2013', max_temp: 62, mean_temp: 58, min_temp: 46, mean_humidity: 50, mean_visibility: 5, mean_wind_speed: 5, precipitation: 0.6)
      @condition_4 = Condition.create!(date: 'Wed, 07 Jan 2013', max_temp: 69, mean_temp: 58, min_temp: 46, mean_humidity: 50, mean_visibility: 8, mean_wind_speed: 8, precipitation: 0.9)
      @trip_1 = @condition_1.trips.create!(duration: 120, start_date: DateTime.strptime('08/04/2015 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('08/04/2015 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
      @trip_2 = @condition_2.trips.create!(duration: 120, start_date: DateTime.strptime('01/05/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/05/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
      @trip_3 = @condition_2.trips.create!(duration: 120, start_date: DateTime.strptime('01/05/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/05/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
      @trip_4 = @condition_2.trips.create!(duration: 120, start_date: DateTime.strptime('01/05/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/05/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
      @trip_5 = @condition_3.trips.create!(duration: 120, start_date: DateTime.strptime('01/06/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/06/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
      @trip_6 = @condition_4.trips.create!(duration: 120, start_date: DateTime.strptime('01/07/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/07/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
      @trip_7 = @condition_4.trips.create!(duration: 120, start_date: DateTime.strptime('01/07/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/07/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
      @trip_8 = @condition_4.trips.create!(duration: 120, start_date: DateTime.strptime('01/07/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/07/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
    end

    it '.most_rides' do
      condition1 = Condition.create(date: Date.strptime('10/12/2015', '%m/%d/%Y'), max_temp: 71.0, mean_temp: 58.0, min_temp: 46.0, mean_humidity: 50.0, mean_visibility: 45.0 , mean_wind_speed: 41.0, precipitation: 93.0)
      condition2 = Condition.create(date: Date.strptime('07/14/2016', '%m/%d/%Y'), max_temp: 81.0, mean_temp: 58.0, min_temp: 46.0, mean_humidity: 50.0, mean_visibility: 45.0 , mean_wind_speed: 41.0, precipitation: 93.0)

      trip1 = condition1.trips.create(duration: 120, start_date: DateTime.strptime('10/12/2015 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'Test Station 2', start_station_id: 2, end_date: DateTime.strptime('10/12/2015 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'Test Station 2', end_station_id: 2, bike_id: 2, subscription_type: 'subscriber', zip_code: '32174')
      trip2 = condition1.trips.create(duration: 130, start_date: DateTime.strptime('10/12/2015 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'Test Station 1', start_station_id: 1, end_date: DateTime.strptime('10/12/2015 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'Test Station 3', end_station_id: 3, bike_id: 2, subscription_type: 'customer', zip_code: '32174')
      trip3 = condition2.trips.create(duration: 140, start_date: DateTime.strptime('07/14/2016 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'Test Station 1', start_station_id: 1, end_date: DateTime.strptime('07/14/2016 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'Test Station 3', end_station_id: 3, bike_id: 2, subscription_type: 'customer', zip_code: '32174')

      expect(Condition.most_rides).to eq(condition1)
    end

    it '.least_rides' do
      condition1 = Condition.create(date: Date.strptime('10/12/2015', '%m/%d/%Y'), max_temp: 71.0, mean_temp: 58.0, min_temp: 46.0, mean_humidity: 50.0, mean_visibility: 45.0 , mean_wind_speed: 41.0, precipitation: 93.0)
      condition2 = Condition.create(date: Date.strptime('07/14/2016', '%m/%d/%Y'), max_temp: 81.0, mean_temp: 58.0, min_temp: 46.0, mean_humidity: 50.0, mean_visibility: 45.0 , mean_wind_speed: 41.0, precipitation: 93.0)

      trip1 = condition1.trips.create(duration: 120, start_date: DateTime.strptime('10/12/2015 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'Test Station 2', start_station_id: 2, end_date: DateTime.strptime('10/12/2015 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'Test Station 2', end_station_id: 2, bike_id: 2, subscription_type: 'subscriber', zip_code: '32174')
      trip2 = condition1.trips.create(duration: 130, start_date: DateTime.strptime('10/12/2015 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'Test Station 1', start_station_id: 1, end_date: DateTime.strptime('10/12/2015 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'Test Station 3', end_station_id: 3, bike_id: 2, subscription_type: 'customer', zip_code: '32174')
      trip3 = condition2.trips.create(duration: 140, start_date: DateTime.strptime('07/14/2016 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'Test Station 1', start_station_id: 1, end_date: DateTime.strptime('07/14/2016 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'Test Station 3', end_station_id: 3, bike_id: 2, subscription_type: 'customer', zip_code: '32174')

      expect(Condition.least_rides).to eq(condition2)
    end

    it '.temp_ranges' do
      expect(Condition.temp_ranges).to eq([[50, 59.9], [60, 69.9]])
    end

    it '.temp_all_rides' do
      expect(Condition.temp_all_rides).to eq([[1, 3], [3, 1]])
    end

    it '.temp_ride_hash' do
      expect(Condition.temp_ride_hash).to eq([[1, 3], [3, 1]])
    end
  end
end
