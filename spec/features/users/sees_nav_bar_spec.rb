require 'rails_helper'

describe 'a user' do
  describe 'visiting any page' do
    before :each do
      user = User.create(first_name: 'Bob', last_name: 'Santos', street: '123 Main Street', city: 'Cranford', state: 'NJ', zip_code: '07016', email: 'Bob@gmail.com', password: 'secretsecret')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end
    it 'should see a nav bar with a Home button that links to the dashboard page' do
      visit stations_path
      within('nav') do
        click_on 'Home'
      end

      expect(current_path).to eq(dashboard_path)
    end
  end
end
