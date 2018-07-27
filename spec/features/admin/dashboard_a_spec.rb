require 'rails_helper'

=begin
As an admin user,
When I visit "/admin/dashboard",
I see a link for viewing all accessories,
When I click that link,
My current path should be "/admin/bike-shop",
I see a table with all accessories (active and inactive)

Each accessory should have:

A thumbnail of the image
Description
Status
Ability to Edit accessory
Ability to Retire/Reactivate accessory
=end

describe 'admin user visits /admin/dashboard' do
  before(:each) do
    @admin = User.create!(first_name: 'pearl',
                         last_name: 'girl',
                         street: '9th ave',
                         city: 'denver',
                         state: 'CO',
                         zip_code: '12345',
                         email: 'pearl@pearl.com',
                         password: 'lovelove',
                         role: 1 )
    @accessory1 = Accessory.create(image_url: 'https://robohash.org/pearl', title: 'unicycle', description: 'one wheel', price: 4, status: 1)
    @accessory2 = Accessory.create(image_url: 'https://robohash.org/heidi', title: 'tricycle', description: 'three wheels', price: 4, status: 0)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  describe 'sees a link to all accessories' do
    it 'sees all active and inactive accessories' do
      visit admin_dashboard_path

      click_on('View all Accessories')

      expect(current_path).to eq(admin_accessories_path)

      expect(page).to have_content(@accessory1.description)
      expect(page).to have_content(@accessory2.description)
      expect(page).to have_content(@accessory1.status)
      expect(page).to have_content(@accessory2.status)
    end

    it 'can edit an accessory' do
      title = 'quinticycle'
      description = 'five wheels'

      visit admin_accessories_path

      within("#accessory-#{@accessory1.id}") do
        click_button('Edit')
      end

      expect(current_path).to eq(edit_admin_accessory_path(@accessory1))

      fill_in 'accessory[title]', with: title
      fill_in 'accessory[description]', with: description
      select 'retired', from: 'accessory[status]'

      click_on 'Update'

      expect(current_path).to eq(admin_accessories_path)

      expect(page).to have_content(title)
      expect(page).to have_content(description)
      # expect(@accessory1.status).to eq('retired')
      expect(page).to have_content("Accessory #{title} updated.")
    end
  end
end
