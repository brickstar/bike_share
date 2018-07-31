require 'rails_helper'

describe 'station show page analysis' do
  before :each do
    user = User.create(first_name: 'Jeff', last_name: 'Casimir', street: '123 Main St', city: 'Denver', state: 'Colorado', zip_code: '80403', email: 'jeff@turing.com', password: 'password', role: 0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

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

    visit "/#{@station_1.slug}"
  end

  it 'does not have access to admin edit and delete functionality' do
    expect(page).to_not have_button('Edit')
    expect(page).to_not have_button('Delete')
  end

  it 'can see the number of rides started here' do
    expect(page).to have_content("\nno. of rides started\n4")
  end

  it 'can see the number of rides ended here' do
    expect(page).to have_content("no. of rides ended\n2")
  end

  it 'can see the most frequent destination station for rides that begin here' do
    expect(page).to have_content("Most frequent destination station: San Fran Park")
  end

  it 'can see the most frequent origination station for rides that end here' do
    expect(page).to have_content("Most frequent origination station: San Fran Park")
  end

  it 'can see the date with the highest number of trips started here' do
    expect(page).to have_content("\nDay with Highest Trip Starts\nDecember 12, 2015\n")
  end

  it 'can see the most frequent zip code for users starting trips here' do
    expect(page).to have_content("Most frequent zip code for users starting trips at this station: 33333")
  end

  it 'can see the Bike ID that most frequently starts a trip here' do
    expect(page).to have_content("Most Popular Bike ID Start\n5")
  end
end
