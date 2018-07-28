require 'rails_helper'

describe 'admin user visits trip new' do
  describe 'fills in a form with trip attributes' do
    it 'should create a trip, land on show and see a flash success' do
      Station.create(name: 'San Jose City Hall', city: 'San Jose', dock_count: 15, installation_date: Date.parse('12 March, 2018'))
      admin = User.create(first_name: 'Pearl', last_name: 'Girl', street: '333 E 9th Ave', city: 'Denver', state: 'CO', zip_code: '12345', email: 'pearl@pearl.com', password: 'lovelove', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      duration            = 234
      start_date          = Date.parse('12 March, 2018')
      start_station_name  = 'San Jose City Hall'
      end_date            = Date.parse('12 March, 2018')
      end_station_name    = 'San Jose City Hall'
      bike_id             = 12
      subscription_type   = 'subscriber'
      zip_code            = '32165'

      visit new_admin_trip_path

      fill_in 'trip[duration]', with: duration
      fill_in 'trip[start_date]', with: start_date
      select start_station_name, from: 'trip[start_station_name]'
      fill_in 'trip[end_date]', with: end_date
      select end_station_name, from: 'trip[end_station_name]'
      fill_in 'trip[bike_id]', with: bike_id
      select subscription_type, from: 'trip[subscription_type]'
      fill_in 'trip[zip_code]', with: zip_code

      click_on 'Create Trip'

      expect(current_path).to eq(trip_path(Trip.last))
      expect(page).to have_content(duration)
      expect(page).to have_content(start_date)
      expect(page).to have_content(start_station_name)
      expect(page).to have_content(end_date)
      expect(page).to have_content(end_station_name)
      expect(page).to have_content(subscription_type)
      expect(page).to have_content(zip_code)
    end
  end
end