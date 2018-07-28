require 'rails_helper'


describe 'admin user visits /admin/dashboard' do
  before(:each) do
    @admin = User.create(first_name: 'pearl',
                         last_name: 'girl',
                         street: '9th ave',
                         city: 'denver',
                         state: 'CO',
                         zip_code: '12345',
                         email: 'pearl@pearl.com',
                         password: 'lovelove',
                         role: 1 )
    @accessory1 = Accessory.create(image_url: 'https://robohash.org/pearl', title: 'unicycle', description: 'one wheel', price: 4, status: 1)
    @accessory2 = Accessory.create(image_url: 'https://robohash.org/heidi', title: 'tricycle', description: 'three wheels', price: 2, status: 0)
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
      expect(page).to have_content(@accessory1.price)
      expect(page).to have_content(@accessory2.price)
    end

    it 'can edit an accessory' do
      title = 'quinticycle'
      description = 'five wheels'
      price = 8

      visit admin_accessories_path

      within("#accessory-#{@accessory1.id}") do
        click_button('Edit')
      end

      expect(current_path).to eq(edit_admin_accessory_path(@accessory1))

      fill_in 'accessory[title]', with: title
      fill_in 'accessory[price]', with: price
      fill_in 'accessory[description]', with: description
      select 'retired', from: 'accessory[status]'

      click_on 'Update Accessory'

      expect(current_path).to eq(admin_accessories_path)

      expect(page).to have_content(title)
      expect(page).to have_content(description)

      within("#accessory-#{@accessory1.id}") do
        expect(page).to have_content("Price: #{price}")
      end

      expect(Accessory.first.status).to eq('retired')
      expect(page).to have_content("Accessory #{title} updated.")
    end
  end
end
