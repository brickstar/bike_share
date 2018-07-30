require 'rails_helper'

describe 'an admin' do
  describe 'visiting any page' do
    before :each do
      admin = User.create(first_name: 'Bob', last_name: 'Santos', street: '123 Main Street', city: 'Cranford', state: 'NJ', zip_code: '07016', email: 'Bob@gmail.com', password: 'secretsecret', role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    end

    it 'should see a nav bar with a Home button that links to the admin dashboard page' do
      visit stations_path
      within('nav') do
        click_on 'Bikeshare'
      end

      expect(current_path).to eq(admin_dashboard_path)
    end
  end
end
