require 'rails_helper'

describe 'visiting the trip show page' do
  before :each do
    @trip = Trip.create(duration: 400, start_date: '12/12/2015 12:12', start_station_name: 'Test Station 1', start_station_id: 1, end_date: '12/12/2015 12:42', end_station_name: 'Test Station 2', end_station_id: 2, bike_id: 2, subscription_type: 'customer', zip_code: '32174')
    user = User.create(first_name: 'Bob', last_name: 'Santos', street: '123 Main Street', city: 'Cranford', state: 'NJ', zip_code: '07016', email: 'Bob@gmail.com', password: 'secretsecret')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
  it 'sees all attributes for the single trip' do
    visit trip_path(@trip)

    expect(page).to have_content(@trip.id)
    expect(page).to have_content(@trip.duration)
    expect(page).to have_content(@trip.start_date)
    expect(page).to have_content(@trip.start_station_name)
    expect(page).to have_content(@trip.end_date)
    expect(page).to have_content(@trip.end_station_name)
    expect(page).to have_content(@trip.subscription_type)
    expect(page).to have_content(@trip.zip_code)
  end
  it 'does not see admin edit and delete buttons' do
    visit trip_path(@trip)

    expect(page).to_not have_button('Edit')
    expect(page).to_not have_button('Delete')
  end
end