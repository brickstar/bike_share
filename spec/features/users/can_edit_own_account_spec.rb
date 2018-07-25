require 'rails_helper'

describe 'when on the dashboard as a logged in user' do
  it 'can click on a button to edit own account information' do
  user = User.create(first_name: 'Jeff',
                     last_name: 'Casimir',
                     street: '123 Main St',
                     city: 'Denver',
                     state: 'Colorado',
                     zip_code: '80403',
                     email: 'jeff@turing.com',
                     password: 'password')
    visit '/'
    click_on 'Login'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Login'
    click_on 'Edit Account'
    fill_in 'first_name', with: 'Billy'
    click_on 'Update'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Billy')
  end
end
