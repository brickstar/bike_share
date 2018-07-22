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
    end

    it 'calculate total count of all stations' do
      expect(Station.total_count).to eq(3)
    end

    it 'calculate average bikes per station' do
      expect(Station.average_bikes_per_station).to eq(5)
    end

    it 'calculate most bikes available' do
      expect(Station.most_bikes_total).to eq(6)
    end

    it 'calculate fewest bikes available' do
      expect(Station.fewest_bikes_total).to eq(4)
    end

    it 'find station with highest bikes available' do
      expect(Station.highest_bike_count).to eq(@station_1)
    end

    it 'find station with lowest bikes available' do
      expect(Station.lowest_bike_count).to eq(@station_3)
    end

    it 'find newest station' do
      expect(Station.newest).to eq(@station_3)
    end

    it 'find oldest station' do
      expect(Station.oldest).to eq(@station_1)
    end
  end
end
