require 'rails_helper'

describe 'login workflow' do
  it 'allows user to log in & log out successfully' do
  user = User.create(first_name: 'Jeff',
                     last_name: 'Casimir',
                     street: '123 Main St',
                     city: 'Denver',
                     state: 'Colorado',
                     zip_code: '80403',
                     email: 'jeff@turing.com',
                     password: 'password',
                     role: 0)

    visit '/'

    within('nav') do
      click_on 'Login'
    end

    expect(current_path).to eq('/login')

    within('nav') do
      expect(page).to_not have_content('Login')
    end

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    within('#existing-user-login') do
      click_on 'Login'
    end

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content('Logged in as: Jeff')
    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.last_name)
    expect(page).to have_content(user.street)
    expect(page).to have_content(user.city)
    expect(page).to have_content(user.state)
    expect(page).to have_content(user.zip_code)
    expect(page).to have_content('Logout')
    expect(page).to_not have_content('Login')

    click_on 'Logout'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Login')
    expect(page).to_not have_content('logout')
  end

  it 'deny user log in accordingly' do
  user = User.create(first_name: 'Jeff',
                     last_name: 'Casimir',
                     street: '123 Main St',
                     city: 'Denver',
                     state: 'Colorado',
                     zip_code: '80403',
                     email: 'jeff@turing.com',
                     password: 'password',
                     role: 0)

    visit '/'

    click_on 'Login'

    expect(current_path).to eq('/login')

    fill_in 'Email', with: user.email

    click_on 'Login'

    expect(current_path).to eq("/login")
    expect(page).to_not have_content('Logged in as: Jeff')
    expect(page).to_not have_content('Logout')
  end
end
