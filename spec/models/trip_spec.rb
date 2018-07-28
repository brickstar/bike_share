require 'rails_helper'

describe Trip, type: :model do
  describe "validations" do
    it { should validate_presence_of(:duration) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:start_station_name) }
    it { should validate_presence_of(:start_station_id) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:end_station_name) }
    it { should validate_presence_of(:end_station_id) }
    it { should validate_presence_of(:bike_id) }
    it { should validate_presence_of(:subscription_type) }
    it { should validate_presence_of(:zip_code) }
  end

  describe "relationships" do
    it { should respond_to(:start_station) }
    it { should respond_to(:end_station) }
  end

  describe 'class methods' do
    before :each do
      @trip1 = Trip.create(duration: 120, start_date: DateTime.strptime('10/12/2015 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'Test Station 2', start_station_id: 2, end_date: DateTime.strptime('10/12/2015 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'Test Station 2', end_station_id: 2, bike_id: 2, subscription_type: 'subscriber', zip_code: '32174')
      @trip2 = Trip.create(duration: 130, start_date: DateTime.strptime('10/13/2015 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'Test Station 1', start_station_id: 1, end_date: DateTime.strptime('10/13/2015 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'Test Station 3', end_station_id: 3, bike_id: 2, subscription_type: 'customer', zip_code: '32174')
      @trip3 = Trip.create(duration: 140, start_date: DateTime.strptime('07/14/2016 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'Test Station 1', start_station_id: 1, end_date: DateTime.strptime('07/14/2016 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'Test Station 3', end_station_id: 3, bike_id: 2, subscription_type: 'customer', zip_code: '32174')
      @trip4 = Trip.create(duration: 150, start_date: DateTime.strptime('09/12/2016 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'Test Station 1', start_station_id: 1, end_date: DateTime.strptime('09/12/2016 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'Test Station 3', end_station_id: 3, bike_id: 3, subscription_type: 'customer', zip_code: '32174')
    end
    it 'should calculate the average duration of all trips' do
      expected = (@trip1.duration + @trip2.duration + @trip3.duration + @trip4.duration) / 4
      actual = Trip.average_duration

      expect(actual).to eq(expected)
    end
    it 'should find the duration of the longest trip' do
      expected = @trip4.duration
      actual = Trip.longest_duration

      expect(actual).to eq(expected)
    end
    it 'should find the duration of the shortest trip' do
      expected = @trip1.duration
      actual = Trip.shortest_duration

      expect(actual).to eq(expected)
    end
    it 'should find the station name with the most starting trips' do
      expected = @trip3.start_station_name
      actual = Trip.station_most_starts

      expect(actual).to eq(expected)
    end
    it 'should find the station name with the most ending trips' do
      expected = @trip4.end_station_name
      actual = Trip.station_most_ends

      expect(actual).to eq(expected)
    end
    it 'should create a hash with each month as a key and number of rides as the value' do

      expected = {
                  Time.parse('2015-10-01').utc.midnight => 2,
                  Time.parse('2016-07-01').utc.midnight => 1,
                  Time.parse('2016-09-01').utc.midnight => 1
                  }
      actual = Trip.breakdown_by_month

      expect(actual).to eq(expected)
    end
    it 'should create a hash with each year as a key and number of rides as the value' do
      expected = {
                  Time.parse('2015-01-01').utc.midnight => 2,
                  Time.parse('2016-01-01').utc.midnight => 2
                  }
      actual = Trip.breakdown_by_year

      expect(actual).to eq(expected)
    end
    it 'should create a table with the bike_id and number of rides ordered high to low' do
      bike_id_table = Trip.bike_id_table

      expect(bike_id_table[0].bike_id).to eq(2)
      expect(bike_id_table[0].number_of_rides).to eq(3)
      expect(bike_id_table[1].bike_id).to eq(3)
      expect(bike_id_table[1].number_of_rides).to eq(1)
    end
  end
end
