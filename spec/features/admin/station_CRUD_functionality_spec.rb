require 'rails_helper'
#
# As an admin user,
# When I visit the stations index,
# I see everything a visitor can see,
# I see a button next to each station to edit that station,
# I also see a button next to each station to delete that station.

describe 'visiting station index page can see all stations with attributes' do
  before :each do
    @admin = User.create(first_name: 'Boss',last_name: 'Lady', street: '123 Main St', city: 'Denver', state: 'CO', zip_code: '80304', email: 'Jeff@Turing.com', password: 'password', role: 1 )
  end

  it 'can see edit and delete buttons per station' do
    
  end
end
