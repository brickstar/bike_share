require 'rails_helper'

describe 'visits trips dashboard' do
  before :each do
    user = User.create(first_name: 'Bob', last_name: 'Santos', street: '123 Main Street', city: 'Cranford', state: 'NJ', zip_code: '07016', email: 'Bob@gmail.com', password: 'secretsecret')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
  it 'sees the average duration of a trip' do
    
  end
  it 'sees the longest trip' do

  end
  it 'sees the shortest trip' do

  end
  it 'sees the statoin with the most rides as a starting place' do

  end
  it 'sees the statoin with the most rides as an ending place' do

  end
end