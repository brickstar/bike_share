require 'rails_helper'

describe 'visiting station show page can see a station with attributes' do
  before :each do
    @admin = User.create(first_name: 'Boss',last_name: 'Lady', street: '123 Main St', city: 'Denver', state: 'CO', zip_code: '80304', email: 'Jeff@Turing.com', password: 'password', role: 1 )
    @station = Station.create(name: 'San Jose City Hall', city: 'San Jose', dock_count: 15, installation_date: 8/6/2013)
  end

  it 'can see edit and delete buttons alongside each station' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    visit "/#{@station.name.parameterize}"

    expect(page).to have_content(@station.name)
    expect(page).to have_content(@station.dock_count)
    expect(page).to have_content(@station.city)
    expect(page).to have_content(@station.installation_date)
    expect(page).to have_button('Edit')
    expect(page).to have_button('Delete')
  end
end
