require 'rails_helper'

=begin

As an admin user,
When I visit "/",
I see a link for "Login",

When I click "Login",
I should be on the "/login" page,
I see a place to insert my credentials to login,
I fill in my desired credentials,
I submit my information,
My current page should be "/admin/dashboard",
I see a message in the navbar that says "Logged in as Admin User: SOME_USER",
I see my profile information,
I do not see a link for "Login",
I see a link for "Logout"

=end

describe 'as an admin user' do
  it 'should login and land on /admin/dashboard' do
    admin = User.create( first_name: 'pearl',
                        last_name: 'girl',
                        street: '9th ave',
                        city: 'denver',
                        state: 'CO',
                        zip_code: '12345',
                        email: 'www.pearl.com',
                        password: 'love',
                        role: 1 )

    visit '/'

    click_on 'Login'

    expect(user.role).to eq('admin')
    expect(user.admin?).to eq(true)

    fill_in :user_first_name, with: admin.first_name
    fill_in :user_last_name, with: admin.last_name
    fill_in :user_street, with: admin.street
    fill_in :user_city, with: admin.city
    fill_in :user_state, with: admin.state
    fill_in :user_zip_code, with: admin.zip_code
    fill_in :user_email, with: admin.email
    fill_in :user_password, with: admin.password

    click_on 'Login'

    expect(current_path).to eq('/admin/dashboard')

    within('nav') do
      expect(page).to have_content("Logged in as Admin User: #{admin.first_name admin.last_name}")
    end

    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.last_name)
    expect(page).to have_content(user.street)
    expect(page).to have_content(user.city)
    expect(page).to have_content(user.state)
    expect(page).to have_content(user.zip_code)
    expect(page).to have_content(user.email)

    expect(page).to have_content('Logout')
    expect(page).to_not have_content('Login')
  end
end
