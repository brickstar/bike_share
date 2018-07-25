require 'rails_helper'

describe 'visits condition show' do
  it 'should see all condition attributes' do
    condition = Condition.create( date: 'Tue, 04 Aug 2015',
                                  max_temp: 74.0,
                                  mean_temp: 68.0,
                                  min_temp: 61.0,
                                  mean_humidity: 61.0,
                                  mean_visibility: 58.0,
                                  mean_wind_speed: 56.0,
                                  precipitation: 93.0 )

    visit condition_path(condition)

    expect(page).to have_content(condition.date)
    expect(page).to have_content(condition.max_temp)
    expect(page).to have_content(condition.mean_temp)
    expect(page).to have_content(condition.min_temp)
    expect(page).to have_content(condition.mean_humidity)
    expect(page).to have_content(condition.mean_visibility)
    expect(page).to have_content(condition.mean_wind_speed)
    expect(page).to have_content(condition.precipitation)
    expect(page).to_not have_button('Edit')
    expect(page).to_not have_button('Delete')
  end
end
