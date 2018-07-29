require 'rails_helper'

describe 'visiting trip index page can see all trips with attributes' do
  before :each do
    @admin = User.create(first_name: 'Boss',last_name: 'Lady', street: '123 Main St', city: 'Denver', state: 'CO', zip_code: '80304', email: 'Jeff@Turing.com', password: 'password', role: 1 )
    @trip1 = Trip.create(duration: 120, start_date: DateTime.strptime('10/12/2015 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'Test Station 2', start_station_id: 2, end_date: DateTime.strptime('10/12/2015 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'Test Station 2', end_station_id: 2, bike_id: 2, subscription_type: 'subscriber', zip_code: '32174')
    @trip2 = Trip.create(duration: 130, start_date: DateTime.strptime('10/13/2015 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'Test Station 1', start_station_id: 1, end_date: DateTime.strptime('10/13/2015 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'Test Station 3', end_station_id: 3, bike_id: 2, subscription_type: 'customer', zip_code: '32174')
    @trip3 = Trip.create(duration: 140, start_date: DateTime.strptime('07/14/2016 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'Test Station 1', start_station_id: 1, end_date: DateTime.strptime('07/14/2016 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'Test Station 3', end_station_id: 3, bike_id: 2, subscription_type: 'customer', zip_code: '32174')
    @trip4 = Trip.create(duration: 150, start_date: DateTime.strptime('09/12/2016 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'Test Station 1', start_station_id: 1, end_date: DateTime.strptime('09/12/2016 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'Test Station 3', end_station_id: 3, bike_id: 3, subscription_type: 'customer', zip_code: '32174')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  it 'can see edit and delete buttons alongside each trip' do
    visit trips_path

    expect(page).to have_content(@trip1.duration)
    expect(page).to have_content(@trip1.start_date)
    expect(page).to have_content(@trip1.start_station_name)
    expect(page).to have_content(@trip1.start_station_id)
    expect(page).to have_content(@trip1.end_date)
    expect(page).to have_content(@trip1.end_station_name)
    expect(page).to have_content(@trip1.bike_id)
    expect(page).to have_content(@trip1.subscription_type)
    expect(page).to have_content(@trip1.zip_code)
    expect(page).to have_button('Edit')
    expect(page).to have_button('Delete')
  end
  
  it 'can delete a trip from the index page' do
    visit trips_path

    expect(page).to have_content("Start Station: #{@trip1.start_station_name}")
    expect(page).to have_content("Start Station: #{@trip2.start_station_name}")
    expect(page).to have_content("Start Station: #{@trip3.start_station_name}")
    expect(page).to have_content("Start Station: #{@trip4.start_station_name}")

    within(".trip_1") do
      click_button 'Delete'
    end

    expect(current_path).to eq(trips_path)
    expect(page).to_not have_content("Trip: #{@trip1.start_station_name}")
    expect(page).to have_content("Successfully deleted trip ##{@trip1.id}.")
  end
end
