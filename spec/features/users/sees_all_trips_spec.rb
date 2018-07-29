require 'rails_helper'

describe 'visiting trips index' do
  before :each do
    30.times do |index|
      Trip.create(duration: index, start_date: '12/12/2015 12:12', start_station_name: 'Test Station 1', start_station_id: 1, end_date: '12/12/2015 12:42', end_station_name: 'Test Station 2', end_station_id: 2, bike_id: 2, subscription_type: 'customer', zip_code: '32174')
    end
    35.times do |index|
      Trip.create(duration: index, start_date: '12/12/2015 12:12', start_station_name: 'Test Station 1', start_station_id: 1, end_date: '12/12/2015 12:42', end_station_name: 'Test Station 2', end_station_id: 2, bike_id: 4, subscription_type: 'customer', zip_code: '32174')
    end
    user = User.create(first_name: 'Bob', last_name: 'Santos', street: '123 Main Street', city: 'Cranford', state: 'NJ', zip_code: '07016', email: 'Bob@gmail.com', password: 'secretsecret')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  it 'sees 30 trips per page' do
    visit trips_path

    expect(page).to have_content('All Trips')
    expect(page).to have_content("Bike ID: #{Trip.first.bike_id}")
    expect(page).to_not have_content("Bike ID: #{Trip.last.bike_id}")
  end

  it 'sees a button to click on and see more trips' do
    visit trips_path

    expect(page).to have_content('Next ›')
  end

  it 'can go forward and back in trips on second trips page' do
    visit trips_path
    click_on 'Next'

    expect(page).to have_content('Next')
    expect(page).to have_content('Prev')
    expect(page).to_not have_content("Bike ID: #{Trip.first.bike_id}")
    expect(page).to have_content("Bike ID: #{Trip.last.bike_id}")

    click_on 'Prev'

    expect(page).to have_content("Bike ID: #{Trip.first.bike_id}")
    expect(page).to_not have_content("Bike ID: #{Trip.last.bike_id}")
  end
  
  it 'does not see admin edit and delete buttons' do
    visit trips_path

    expect(page).to_not have_button('Edit')
    expect(page).to_not have_button('Delete')
  end
end
