require 'rails_helper'

=begin

As an admin user,
When I visit admin condition edit,
I fill in a form with all condition attributes,
When I click "Update Condition",
I am directed to that condition's show page,
I see the updated condition's information,
I also see a flash message that I have updated that condition.

** All Attributes must be present **
=end
describe 'admin user visits conditions edit' do
  describe 'fills in a form with all condition attriubutes' do
    it 'should land on condition show, see updated info and flash message' do
      admin = User.create!(first_name: 'Pearl', last_name: 'Girl', street: '333 E 9th Ave', city: 'Denver', state: 'CO', zip_code: '12345', email: 'pearl@pearl.com', password: 'lovelove', role: 1)
      condition = Condition.create!(date: 'Mon, 03 Jul 2014',
                                    max_temp: 1,
                                    mean_temp: 2,
                                    min_temp: 3,
                                    mean_humidity: 4,
                                    mean_visibility: 5,
                                    mean_wind_speed: 6,
                                    precipitation: 7.0)

      date            = 'Tue, 04 Aug 2015'
      max_temp        = 10
      mean_temp       = 20
      min_temp        = 30
      mean_humidity   = 40
      mean_visibility = 50
      mean_wind_speed = 60
      precipitation   = 70.0

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit edit_admin_condition_path(condition)

      fill_in 'condition[date]', with: date
      fill_in 'condition[max_temp]', with: max_temp
      fill_in 'condition[mean_temp]', with: mean_temp
      fill_in 'condition[min_temp]', with: min_temp
      fill_in 'condition[mean_humidity]', with: mean_humidity
      fill_in 'condition[mean_visibility]', with: mean_visibility
      fill_in 'condition[mean_wind_speed]', with: mean_wind_speed
      fill_in 'condition[precipitation]', with: precipitation

      click_on 'Update Condition'

      expect(current_path).to eq(condition_path(condition))
      expect(page).to have_content("Weather condition for #{Condition.first.date} updated.")
      expect(page).to have_content(precipitation)
    end
  end
end
