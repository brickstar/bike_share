require 'rails_helper'

describe 'registration workflow' do
  it 'allows visitor to create account and logout succesfully' do
    first_name = 'Jeff'
    last_name = 'Casimir'
    street = '123 Main Street'
    city = 'Denver'
    state = 'Colorado'
    zip_code = '80304'
    email = 'Jeff@Turing.com'
    password = 'password'

    visit '/'

    click_on 'Login'
    expect(current_path).to eq('/login')
    expect(page).to have_content('Create Account')

    click_on 'Create Account'

    fill_in :user_first_name, with: first_name
    fill_in :user_last_name, with: last_name
    fill_in :user_street, with: street
    fill_in :user_city, with: city
    fill_in :user_state, with: state
    fill_in :user_zip_code, with: zip_code
    fill_in :user_email, with: email
    fill_in :user_password, with: password

    click_on 'Create Account'
    expect(current_path).to eq('/dashboard')
    expect(page).to have_content('Logged in as: Jeff')
    expect(page).to have_content(first_name)
    expect(page).to have_content(last_name)
    expect(page).to have_content(street)
    expect(page).to have_content(city)
    expect(page).to have_content(state)
    expect(page).to have_content(zip_code)
    expect(page).to have_content('Logout')
    expect(page).to_not have_content('Login')

    click_on 'Logout'
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Login')
    expect(page).to_not have_content('logout')
  end

  it 'deny visitor account setup' do
    first_name = 'Jeff'
    last_name = 'Casimir'
    street = '123 Main Street'
    city = 'Denver'
    state = 'Colorado'
    zip_code = '80304'
    email = 'Jeff@Turing.com'
    password = 'password'

    visit '/'

    click_on 'Login'
    expect(current_path).to eq('/login')

    click_on 'Create Account'

    fill_in :user_first_name, with: first_name
    fill_in :user_last_name, with: last_name
    fill_in :user_city, with: city
    fill_in :user_state, with: state
    fill_in :user_zip_code, with: zip_code
    fill_in :user_email, with: email
    fill_in :user_password, with: password

    click_on 'Create Account'
    expect(current_path).to eq('/login')
    expect(page).to_not have_content('Logged in as: Jeff')
    expect(page).to_not have_content('Logout')
    expect(page).to_not have_content('Login')
  end
end
