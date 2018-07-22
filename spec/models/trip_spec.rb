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
  describe 'class methods' do
    before :each do
      @trip1 = Trip.create(duration: 120, start_date: '12/12/2015 12:12', start_station_name: 'Test Station 1', start_station_id: 1, end_date: '12/12/2015 12:42', end_station_name: 'Test Station 2', end_station_id: 2, bike_id: 2, subscription_type: 'subscriber', zip_code: '32174')
      @trip2 = Trip.create(duration: 130, start_date: '12/12/2015 12:12', start_station_name: 'Test Station 1', start_station_id: 1, end_date: '12/12/2015 12:42', end_station_name: 'Test Station 2', end_station_id: 2, bike_id: 2, subscription_type: 'customer', zip_code: '32174')
      @trip3 = Trip.create(duration: 140, start_date: '12/12/2015 12:12', start_station_name: 'Test Station 2', start_station_id: 2, end_date: '12/12/2015 12:42', end_station_name: 'Test Station 2', end_station_id: 2, bike_id: 2, subscription_type: 'customer', zip_code: '32174')
      @trip4 = Trip.create(duration: 150, start_date: '12/12/2015 12:12', start_station_name: 'Test Station 2', start_station_id: 2, end_date: '12/12/2015 12:42', end_station_name: 'Test Station 2', end_station_id: 2, bike_id: 2, subscription_type: 'customer', zip_code: '32174')
    end
    it 'should calculate the average duration of all trips' do
      expected = (@trip1.duration + @trip2.duration + @trip3.duration + @trip4.duration) / 4
      actual = Trip.average_duration

      expect(actual).to eq(expected)
    end
  end
end
