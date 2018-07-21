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

    visit '/'

    click_on 'Login'
    expect(current_path).to eq('/login')
    expect(page).to have_content('Create Account')

    click_on 'Create Account'

    fill_in :first_name, with: 'Jeff'
    fill_in :last_name, with: 'Casimir'
    fill_in :street, with: '123 Main Street'
    fill_in :city, with: 'Denver'
    fill_in :state, with: 'Colorado'
    fill_in :zip_code, with: '80403'
    fill_in :email, with: 'Jeff@Turing.com'
    fill_in :password, with: 'password'

    click_on 'Submit'

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content('Logged in as Jeff')
    expect(page).to have_content('First Name: Jeff')
    expect(page).to have_content('Last Name: Casimir')
    expect(page).to have_content('Street: 123 Main Street')
    expect(page).to have_content('City: Denver')
    expect(page).to have_content('State: Colorado')
    expect(page).to have_content('Zip Code: 80403')
    expect(page).to have_content('Logout')
    expect(page).to_not have_content('Login')
  end
end
