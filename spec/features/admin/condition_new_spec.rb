require 'rails_helper'

describe 'admin user visits condition new' do
  describe 'fills in a form with condition attributes' do
    it 'should create a condition, land on show and see a flash success' do
      admin = User.create(first_name: 'Pearl', last_name: 'Girl', street: '333 E 9th Ave', city: 'Denver', state: 'CO', zip_code: '12345', email: 'pearl@pearl.com', password: 'lovelove', role: 1)

      date            = 'Tue, 04 Aug 2015'
      max_temp        = 1
      mean_temp       = 2
      min_temp        = 3
      mean_humidity   = 4
      mean_visibility = 5
      mean_wind_speed = 6
      precipitation   = 7.0

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit new_admin_condition_path

      fill_in 'condition[date]', with: date
      fill_in 'condition[max_temp]', with: max_temp
      fill_in 'condition[mean_temp]', with: mean_temp
      fill_in 'condition[min_temp]', with: min_temp
      fill_in 'condition[mean_humidity]', with: mean_humidity
      fill_in 'condition[mean_visibility]', with: mean_visibility
      fill_in 'condition[mean_wind_speed]', with: mean_wind_speed
      fill_in 'condition[precipitation]', with: precipitation

      click_on 'Create Condition'

      expect(current_path).to eq(condition_path(Condition.last))
      expect(page).to have_content("Weather condition for #{Condition.last.date} created.")
      expect(page).to have_content(Condition.last.precipitation)
    end

    it 'should deny a condition, if invalid credentials provided' do
      admin = User.create(first_name: 'Pearl', last_name: 'Girl', street: '333 E 9th Ave', city: 'Denver', state: 'CO', zip_code: '12345', email: 'pearl@pearl.com', password: 'lovelove', role: 1)

      date            = 'Tue, 04 Aug 2015'
      max_temp        = 1
      mean_temp       = 2
      min_temp        = 3
      mean_humidity   = 4
      mean_visibility = 5
      mean_wind_speed = 6
      precipitation   = 7.0

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit new_admin_condition_path

      fill_in 'condition[date]', with: date
      fill_in 'condition[max_temp]', with: max_temp
      fill_in 'condition[mean_temp]', with: mean_temp
      fill_in 'condition[min_temp]', with: min_temp
      fill_in 'condition[mean_wind_speed]', with: mean_wind_speed
      fill_in 'condition[precipitation]', with: precipitation

      click_on 'Create Condition'

      expect(current_path).to eq(admin_conditions_path)
      expect(page).to have_content("Missing required fields, condition was not created.")
    end
  end
end
