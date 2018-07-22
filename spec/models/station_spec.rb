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
      Station.create(name: 'San Jose City Hall', city: 'San Jose', dock_count: 15, installation_date: 8/6/2013)
      Station.create(name: 'Mountain View City Hall', city: 'Mountain View', dock_count: 17, installation_date: 8/16/2014)
      Station.create(name: 'Market at 10th', city: 'San Francisco', dock_count: 27, installation_date: 1/23/2013)
    end

    it 'calculate total count of all stations' do
      expect(Station.average_total_count).to eq(3)
    end

    xit 'calculate average bikes per station' do
    end

    xit 'calculate most bikes available' do
    end

    xit 'calculate fewest bikes available' do
    end

    xit 'find station with most bikes available' do
    end

    xit 'find station with least bikes available' do
    end

    xit 'find oldest station' do
    end

    xit 'find newest station' do 
    end

  end
end
