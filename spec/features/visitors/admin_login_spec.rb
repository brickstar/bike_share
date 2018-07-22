require 'rails_helper'

describe 'an admin user' do
  it 'should land on /admin/dashboard after login,
      and see their name in navbar and profile information' do
    admin = User.create(first_name: 'pearl',
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

    within('#admin-nav') do
      expect(page).to have_content("Logged in as Admin User: #{admin.first_name}")
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
