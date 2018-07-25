require 'rails_helper'

describe 'admin user visits conditions show' do
  before(:each) do
    @admin = User.create(first_name: 'Pearl', last_name: 'Girl', street: '333 E 9th Ave', city: 'Denver', state: 'CO', zip_code: '12345', email: 'pearl@pearl.com', password: 'lovelove', role: 1)
    @condition = Condition.create(date: 'Tue, 04 Aug 2015', max_temp: 71.0, mean_temp: 58.0, min_temp: 46.0, mean_humidity: 50.0, mean_visibility: 45.0 , mean_wind_speed: 41.0, precipitation: 93.0)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  it 'sees condition attributes, edit and delete buttons' do

    visit condition_path(@condition)

    expect(page).to have_button('Edit')
    expect(page).to have_button('Delete')
    expect(page).to have_content(@condition.date)
    expect(page).to have_content(@condition.max_temp)
    expect(page).to have_content(@condition.mean_temp)
    expect(page).to have_content(@condition.min_temp)
    expect(page).to have_content(@condition.mean_humidity)
    expect(page).to have_content(@condition.mean_visibility)
    expect(page).to have_content(@condition.mean_wind_speed)
    expect(page).to have_content(@condition.precipitation)
  end

  it 'can delete a condition' do

    visit conditions_path(@condition)

    expect(page).to have_content(@condition.date)

    click_button('Delete')

    expect(current_path).to eq(conditions_path)
    expect(page).to_not have_content(@condition.date)
    expect(page).to_not have_content(@condition.precipitation)
    expect(page).to have_content("Successfully deleted condition ##{@condition.id}")
  end
end
