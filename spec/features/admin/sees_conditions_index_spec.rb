require 'rails_helper'

describe 'admin user visits conditions index' do
  before(:each) do
    @admin = User.create(first_name: 'Pearl', last_name: 'Girl', street: '333 E 9th Ave', city: 'Denver', state: 'CO', zip_code: '12345', email: 'pearl@pearl.com', password: 'lovelove', role: 1)
    @condition_1 = Condition.create(date: 'Tue, 04 Aug 2015', max_temp: 74.0, mean_temp: 68.0, min_temp: 61.0, mean_humidity: 61.0, mean_visibility: 58.0 , mean_wind_speed: 56.0, precipitation: 93.0)
    @condition_2 = Condition.create(date: 'Wed, 05 Jan 2013', max_temp: 71.0, mean_temp: 58.0, min_temp: 46.0, mean_humidity: 50.0, mean_visibility: 45.0 , mean_wind_speed: 41.0, precipitation: 0.0)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  it 'sees all conditions and buttons to edit and delete each condition' do

    visit conditions_path

    within("#condition-#{@condition_1.id}") do
      expect(page).to have_button('Edit')
      expect(page).to have_button('Delete')
    end

    within("#condition-#{@condition_2.id}") do
      expect(page).to have_button('Edit')
      expect(page).to have_button('Delete')
    end

    expect(page).to have_content(@condition_1.date)
    expect(page).to have_content(@condition_1.max_temp)
    expect(page).to have_content(@condition_1.mean_temp)
    expect(page).to have_content(@condition_1.min_temp)
    expect(page).to have_content(@condition_1.mean_humidity)
    expect(page).to have_content(@condition_1.mean_visibility)
    expect(page).to have_content(@condition_1.mean_wind_speed)
    expect(page).to have_content(@condition_1.precipitation)
    expect(page).to have_content(@condition_2.date)
    expect(page).to have_content(@condition_2.max_temp)
    expect(page).to have_content(@condition_2.mean_temp)
    expect(page).to have_content(@condition_2.min_temp)
    expect(page).to have_content(@condition_2.mean_humidity)
    expect(page).to have_content(@condition_2.mean_visibility)
    expect(page).to have_content(@condition_2.mean_wind_speed)
    expect(page).to have_content(@condition_2.precipitation)
  end

  it 'can delete a condition' do

    visit conditions_path

    expect(page).to have_content(@condition_2.date)

    within("#condition-#{@condition_2.id}") do
      click_button('Delete')
    end

    expect(current_path).to eq(conditions_path)
    expect(page).to_not have_content(@condition_2.date)
    expect(page).to_not have_content(@condition_2.precipitation)
    expect(page).to have_content("Successfully deleted condition ##{@condition_2.id}")
  end
end
