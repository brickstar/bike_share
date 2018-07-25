require 'rails_helper'

=begin
As a admin user,
When I visit admin condition new,
I fill in a form with all condition attributes,
When I click "Create Condition",
I am directed to a that condition's show page.
I also see a flash message that I have created that condition.

** All Attributes must be present **
=end

describe 'admin user visits condition new' do
  describe 'fills in a form with condition attributes' do
    it 'should create a condition, land on show and see a flash success' do
      date            = 'Tue, 04 Aug 2015'
      max_temp        = 1
      mean_temp       = 2
      min_temp        = 3
      mean_humidity   = 4
      mean_visibility = 5
      mean_wind_speed = 6
      precipitation   = 7.0

      visit new_admin_conditon_path

      fill_in :max_temp, with: max_temp
      fill_in :max_temp, with: mean_temp
      fill_in :max_temp, with: min_temp
      fill_in :max_temp, with: mean_humidity
      fill_in :max_temp, with: mean_visibility
      fill_in :max_temp, with: mean_wind_speed
      fill_in :max_temp, with: precipitation

      click_on 'Create Condition'

      expect(current_path).to eq(admin_condition_path(Condition.last))
      expect(page).to have_content("Condition successfully created.")
      expect(page).to have_content(Condition.last.precipitation)
    end
  end
end
