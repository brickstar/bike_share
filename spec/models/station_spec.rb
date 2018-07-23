require 'rails_helper'

describe Station, type: :model do

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:dock_count) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:installation_date) }
  end

  describe "class methods" do
    before :each do
      @station_1 = Station.create(name: 'San Jose City Hall', city: 'San Jose', dock_count: 6, installation_date: '8/6/2013')
      @station_2 = Station.create(name: 'Mountain View City Hall', city: 'Mountain View', dock_count: 5, installation_date: '8/16/2014')
      @station_3 = Station.create(name: 'Market at 10th', city: 'San Francisco', dock_count: 4, installation_date: '1/23/2016')
      @station_4 = Station.create(name: 'San Francisco City Park', city: 'San Francisco', dock_count: 6, installation_date: '8/6/2013')
      @station_5 = Station.create(name: 'Main at 2nd', city: 'San Francisco', dock_count: 6, installation_date: '8/16/2014')
      @station_6 = Station.create(name: 'Market at 28th', city: 'San Francisco', dock_count: 4, installation_date: '12/23/2015')
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
end
