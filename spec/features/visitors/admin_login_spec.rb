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
  it 'should login and land on /admin/dashboard,
        see flash message and profile information' do
    admin = User.create!( first_name: 'pearl',
                        last_name: 'girl',
                        street: '9th ave',
                        city: 'denver',
                        state: 'CO',
                        zip_code: '12345',
                        email: 'pearl@pearl.com',
                        password: 'lovelove',
                        role: 1 )

    visit login_path

    fill_in :email, with: admin.email
    fill_in :password, with: admin.password

    expect(admin.role).to eq('admin')
    expect(admin.admin?).to eq(true)

    click_on 'Login'

    expect(current_path).to eq(admin_dashboard_path(admin))

    within('nav') do
      expect(page).to have_content("Logged in as Admin User: #{admin.first_name admin.last_name}")
    end

    expect(page).to have_content(admin.first_name)
    expect(page).to have_content(admin.last_name)
    expect(page).to have_content(admin.street)
    expect(page).to have_content(admin.city)
    expect(page).to have_content(admin.state)
    expect(page).to have_content(admin.zip_code)
    expect(page).to have_content(admin.email)

    expect(page).to have_content('Logout')
    expect(page).to_not have_content('Login')
  end
end
