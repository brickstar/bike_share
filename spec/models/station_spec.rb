require 'rails_helper'

describe Station, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:dock_count) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:installation_date) }
  end

  describe "relationships" do
    it { should respond_to(:start_trips) }
    it { should respond_to(:end_trips) }
  end

  describe "class methods" do
    before :each do
      @station_1 = Station.create(name: 'San Jose City Hall', city: 'San Jose', dock_count: 6, installation_date: Date.strptime('8/6/2013', '%m/%d/%Y'))
      @station_2 = Station.create(name: 'Mountain View City Hall', city: 'Mountain View', dock_count: 5, installation_date: Date.strptime('8/16/2014', '%m/%d/%Y'))
      @station_3 = Station.create(name: 'Market at 10th', city: 'San Francisco', dock_count: 4, installation_date: Date.strptime('1/23/2016', '%m/%d/%Y'))
      @station_4 = Station.create(name: 'San Francisco City Park', city: 'San Francisco', dock_count: 6, installation_date: Date.strptime('8/6/2013', '%m/%d/%Y'))
      @station_5 = Station.create(name: 'Main at 2nd', city: 'San Francisco', dock_count: 6, installation_date: Date.strptime('8/16/2014', '%m/%d/%Y'))
      @station_6 = Station.create(name: 'Market at 28th', city: 'San Francisco', dock_count: 4, installation_date: Date.strptime('12/13/2015', '%m/%d/%Y'))
    end

    it 'calculate total count of all stations' do
      expect(Station.total_count).to eq(6)
    end

    it 'calculate average bikes per station' do
      average = Station.average(:dock_count)
      expect(Station.average_bikes_per_station).to eq(average)
    end

    it 'calculate most bikes available' do
      expect(Station.highest_bike_total).to eq(6)
    end

    it 'calculate fewest bikes available' do
      expect(Station.lowest_bike_total).to eq(4)
    end

    it 'find stations with highest bikes available' do
      expect(Station.with_highest_inventory.size).to eq(3)
      expect(Station.with_highest_inventory).to match_array [@station_1, @station_4, @station_5]
    end

    it 'find stations with lowest bikes available' do
      expect(Station.with_lowest_inventory).to match_array [@station_3, @station_6]
    end

    it 'find newest station' do
      expect(Station.newest).to match_array [@station_3]
  end

    it 'find oldest station' do
      expect(Station.oldest).to match_array [@station_1, @station_4]
    end
  end

  describe "instance methods" do
    before :each do
      @station_1 = Station.create(name: 'San Jose City Hall', city: 'San Jose', dock_count: 6,installation_date: Date.strptime('8/6/2013', '%m/%d/%Y'))
      @station_2 = Station.create(name: 'San Fran Park', city: 'San Fransisco', dock_count: 12, installation_date: Date.strptime('6/2/2014', '%m/%d/%Y'))
      @trip1 = Trip.create(duration: 120, start_date: '12/12/2015 12:12', start_station_name: 'San Fran Park', start_station_id: 2, end_date: '12/12/2015 12:42', end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 2, subscription_type: 'subscriber', zip_code: '32174')
      @trip2 = Trip.create(duration: 130, start_date: '12/12/2015 12:12', start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: '12/12/2015 12:42', end_station_name: 'San Fran Park', end_station_id: 2, bike_id: 2, subscription_type: 'customer', zip_code: '32174')
      @trip3 = Trip.create(duration: 140, start_date: '12/12/2015 12:12', start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: '12/12/2015 12:42', end_station_name: 'San Fran Park', end_station_id: 2, bike_id: 1, subscription_type: 'customer', zip_code: '32174')
      @trip4 = Trip.create(duration: 150, start_date: '12/12/2015 12:12', start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: '12/12/2015 12:42', end_station_name: 'San Fran Park', end_station_id: 2, bike_id: 2, subscription_type: 'customer', zip_code: '32174')
    end

    it 'find total number of trips that began here' do
      expect(@station_1.total_trips_started).to eq(3)
    end

    it 'find total number of trips that ended here' do
      expect(@station_1.total_trips_ended).to eq(1)
    end

    xit 'find most frequent destination for rides beginning here' do
      expect(@station_1.most_riders_went_to).to eq(@station_2)
    end

    xit 'find most frequent origination for rides that end here' do
      expect(@station_1.most_riders_came_from).to eq(@station_2)
    end

    xit 'find the date with the highest number of trips started here' do
      expect(@station_1.highest_start_volume_date).to eq('12/12/2015')
    end

    xit 'find the most frequent zip code for users starting trips here' do
      expect(@station_1.most_users_from_zipcode).to eq('32174')
    end

    xit 'find the Bike ID that most frequently starts a trip here' do
      expect(@station_1.most_started_bike_id).to eq(2)
    end
  end
end
