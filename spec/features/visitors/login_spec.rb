require 'rails_helper'

=begin
As a visitor,
When I visit "/",
I see a link for "Login",
When I click "Login",
I should be on the "/login" page,
I see a link to "Create Account",
When I click link "Create Account",
I fill in my desired credentials,
And I submit my information,
My current page should be "/dashboard",
I see a message in the navbar that says "Logged in as SOME_USER",
I see my profile information,
I do not see a link for "Login",
I also see a link for "Logout".
=end

describe 'login workflow' do
  it 'allows a visitor to create an account and log in successfully' do
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

    click_on 'Create User'

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content('Logged in as Jeff')
    expect(page).to have_content(first_name)
    expect(page).to have_content(last_name)
    expect(page).to have_content(street)
    expect(page).to have_content(city)
    expect(page).to have_content(state)
    expect(page).to have_content(zip_code)
    expect(page).to have_content('Logout')
    expect(page).to_not have_content('Login')
  end
end
