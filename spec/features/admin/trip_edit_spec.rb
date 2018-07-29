require 'rails_helper'

describe 'admin user visits trip new' do
  describe 'fills in a form with trip attributes' do
    before :each do
      Station.create(name: 'San Jose City Hall', city: 'San Jose', dock_count: 15, installation_date: Date.parse('12 March, 2018'))
      @trip1 = Trip.create(duration: 120, start_date: DateTime.strptime('10/12/2015 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('10/12/2015 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
      @trip2 = Trip.create(duration: 130, start_date: DateTime.strptime('10/13/2015 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('10/13/2015 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 2, subscription_type: 'customer', zip_code: '32174')
      @admin = User.create(first_name: 'Boss',last_name: 'Lady', street: '123 Main St', city: 'Denver', state: 'CO', zip_code: '80304', email: 'Jeff@Turing.com', password: 'password', role: 1 )
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    end
    
    it 'should create a trip, land on show and see a flash success' do
      visit edit_admin_trip_path(@trip1)

      duration = 123456789

      fill_in 'trip[duration]', with: duration

      click_on 'Update Trip'

      expect(current_path).to eq(trip_path(@trip1))
      expect(page).to have_content(duration)
    end
  end
end
