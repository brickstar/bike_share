require 'rails_helper'

=begin
As a visitor,
When I visit the conditions index,
I see all conditions (Date, Max Temperature, Mean Temperature, Min Temperature, Mean Humidity, Mean Visibility (in Miles), Mean Wind Speed (mph), Precipitation (inches))
** All Attributes must be present **
=end

describe 'visiting the conditions index' do
  it 'sees a list of all conditions' do
    condition_1 = Condition.create(date: '8/29/2013', max_temp: 74.0, mean_temp: 68.0, min_temp: 61.0, mean_humidity: 61.0, mean_visibility: 58.0 , mean_wind_speed: 56.0, precipitation: 93.0)
    condition_2 = Condition.create(date: '2/24/2014', max_temp: 71.0, mean_temp: 58.0, min_temp: 46.0, mean_humidity: 50.0, mean_visibility: 45.0 , mean_wind_speed: 41.0, precipitation: 93.0)

    visit conditions_path

    expect(current_path).to eq(conditions_path)
    expect(page).to have_content(station_1.date)
    expect(page).to have_content(station_2.date)
    expect(page).to have_content(station_1.max_temp)
    expect(page).to have_content(station_2.max_temp)
    expect(page).to have_content(station_1.mean_temp)
    expect(page).to have_content(station_2.mean_temp)
    expect(page).to have_content(station_1.min_temp)
    expect(page).to have_content(station_2.min_temp)
    expect(page).to have_content(station_1.mean_humidity)
    expect(page).to have_content(station_2.mean_humidity)
    expect(page).to have_content(station_1.mean_visibility)
    expect(page).to have_content(station_2.mean_visibility)
    expect(page).to have_content(station_1.mean_wind_speed)
    expect(page).to have_content(station_2.mean_wind_speed)
    expect(page).to have_content(station_1.precipitation)
    expect(page).to have_content(station_2.precipitation)
  end
end
