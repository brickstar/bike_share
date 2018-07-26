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
      @station_3 = Station.create(name: 'Market Street', city: 'San Fransisco', dock_count: 4, installation_date: Date.strptime('6/8/2014', '%m/%d/%Y'))

      @t_2 = Trip.create(duration: 130, start_date: '12/12/2015 12:12', start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: '12/12/2015 12:42', end_station_name: 'San Fran Park', end_station_id: 2, bike_id: 5, subscription_type: 'customer', zip_code: '33333')
      @t_3 = Trip.create(duration: 140, start_date: '10/11/2014 12:12', start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: '10/11/2014 12:42', end_station_name: 'Market Street', end_station_id: 3, bike_id: 5, subscription_type: 'customer', zip_code: '77777')
      @t_7 = Trip.create(duration: 180, start_date: '12/12/2015 12:12', start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: '12/12/2015 12:42', end_station_name: 'San Fran Park', end_station_id: 2, bike_id: 8, subscription_type: 'customer', zip_code: '33333')
      @t_4 = Trip.create(duration: 110, start_date: '11/05/2017 12:12', start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: '11/05/2017 12:30', end_station_name: 'San Fran Park', end_station_id: 2, bike_id: 3, subscription_type: 'customer', zip_code: '33333')

      @t_1 = Trip.create(duration: 120, start_date: '10/05/2014 12:12', start_station_name: 'San Fran Park', start_station_id: 2, end_date: '10/05/2014 12:42', end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 10, subscription_type: 'subscriber', zip_code: '55555')
      @t_6 = Trip.create(duration: 170, start_date: '10/05/2014 12:12', start_station_name: 'San Fran Park', start_station_id: 2, end_date: '12/12/2015 12:42', end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 10, subscription_type: 'customer', zip_code: '55555')

      @t_5 = Trip.create(duration: 160, start_date: '12/12/2015 12:12', start_station_name: 'Market Street', start_station_id: 3, end_date: '12/12/2015 12:42', end_station_name: 'San Fran Park', end_station_id: 2, bike_id: 6, subscription_type: 'subscriber', zip_code: '77777')
      @t_8 = Trip.create(duration: 190, start_date: '12/12/2015 12:12', start_station_name: 'Market Street', start_station_id: 3, end_date: '12/12/2015 12:42', end_station_name: 'San Fran Park', end_station_id: 2, bike_id: 6, subscription_type: 'customer', zip_code: '77777')
    end

#I see the Number of rides started at this station,
    it 'find total number of trips that began here' do
      expect(@station_1.total_trips_started).to eq(4)
      expect(@station_2.total_trips_started).to eq(2)
      expect(@station_3.total_trips_started).to eq(2)
    end

#I see the Number of rides ended at this station,
    it 'find total number of trips that ended here' do
      expect(@station_1.total_trips_ended).to eq(2)
      expect(@station_2.total_trips_ended).to eq(5)
      expect(@station_3.total_trips_ended).to eq(1)
    end

#I see the Most frequent destination station (for rides that began at this station)
    it 'find most frequent destination for rides beginning here' do
      expect(@station_1.most_riders_went_to).to eq('San Fran Park')
      expect(@station_2.most_riders_went_to).to eq('San Jose City Hall')
      expect(@station_3.most_riders_went_to).to eq('San Fran Park')
    end

#I see the Most frequent origination station (for rides that ended at this station),
    xit 'find most frequent origination for rides that end here' do
      expect(@station_1.most_riders_came_from).to eq('San Fran Park')
      expect(@station_2.most_riders_came_from).to eq('San Jose City Hall')
      expect(@station_3.most_riders_came_from).to eq('San Jose City Hall')
    end

#I see the Date with the highest number of trips started at this station,
    xit 'find the date with the highest number of trips started here' do
      expect(@station_1.highest_start_volume_date).to eq('12/12/2015')
      expect(@station_2.highest_start_volume_date).to eq('10/05/2014')
      expect(@station_3.highest_start_volume_date).to eq('12/12/2015')
    end

#I see the Most frequent zip code for users starting trips at this station,
    xit 'find the most frequent zip code for users starting trips here' do
      expect(@station_1.most_users_from_zipcode).to eq('33333')
      expect(@station_2.most_users_from_zipcode).to eq('55555')
      expect(@station_3.most_users_from_zipcode).to eq('77777')
    end

#I see the Bike ID most frequently starting a trip at this station.
    xit 'find the Bike ID that most frequently starts a trip here' do
      expect(@station_1.most_started_bike_id).to eq(5)
      expect(@station_2.most_started_bike_id).to eq(10)
      expect(@station_3.most_started_bike_id).to eq(6)
    end
  end
end
