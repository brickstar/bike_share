require 'rails_helper'

describe 'visiting trip show page can see all attributes' do
  before :each do
    @admin = User.create(first_name: 'Boss',last_name: 'Lady', street: '123 Main St', city: 'Denver', state: 'CO', zip_code: '80304', email: 'Jeff@Turing.com', password: 'password', role: 1 )
    @trip1 = Trip.create(duration: 120, start_date: DateTime.strptime('10/12/2015 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'Test Station 2', start_station_id: 2, end_date: DateTime.strptime('10/12/2015 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'Test Station 2', end_station_id: 2, bike_id: 2, subscription_type: 'subscriber', zip_code: '32174')
  end
  it 'can see edit and delete buttons' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    visit trip_path(@trip1)

    expect(page).to have_content(@trip1.id)
    expect(page).to have_content(@trip1.duration)
    expect(page).to have_content(@trip1.start_date)
    expect(page).to have_content(@trip1.start_station_name)
    expect(page).to have_content(@trip1.start_station_id)
    expect(page).to have_content(@trip1.end_date)
    expect(page).to have_content(@trip1.end_station_name)
    expect(page).to have_content(@trip1.end_station_id)
    expect(page).to have_content(@trip1.bike_id)
    expect(page).to have_content(@trip1.subscription_type)
    expect(page).to have_content(@trip1.zip_code)
    expect(page).to have_button('Edit')
    expect(page).to have_button('Delete')
  end
end
