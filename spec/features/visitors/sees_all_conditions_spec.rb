require 'rails_helper'

describe 'visiting the conditions index' do
  it 'sees a list of all conditions' do
    condition_1 = Condition.create(date: 'Tue, 04 Aug 2015', max_temp: 74.0, mean_temp: 68.0, min_temp: 61.0, mean_humidity: 61.0, mean_visibility: 58.0 , mean_wind_speed: 56.0, precipitation: 93.0)
    condition_2 = Condition.create(date: 'Tue, 05 Aug 2015', max_temp: 71.0, mean_temp: 58.0, min_temp: 46.0, mean_humidity: 50.0, mean_visibility: 45.0 , mean_wind_speed: 41.0, precipitation: 93.0)

    visit conditions_path

    expect(current_path).to eq(conditions_path)
    expect(page).to have_content(condition_1.date)
    expect(page).to have_content(condition_2.date)
    expect(page).to have_content(condition_1.max_temp)
    expect(page).to have_content(condition_2.max_temp)
    expect(page).to have_content(condition_1.mean_temp)
    expect(page).to have_content(condition_2.mean_temp)
    expect(page).to have_content(condition_1.min_temp)
    expect(page).to have_content(condition_2.min_temp)
    expect(page).to have_content(condition_1.mean_humidity)
    expect(page).to have_content(condition_2.mean_humidity)
    expect(page).to have_content(condition_1.mean_visibility)
    expect(page).to have_content(condition_2.mean_visibility)
    expect(page).to have_content(condition_1.mean_wind_speed)
    expect(page).to have_content(condition_2.mean_wind_speed)
    expect(page).to have_content(condition_1.precipitation)
    expect(page).to have_content(condition_2.precipitation)
  end
end
