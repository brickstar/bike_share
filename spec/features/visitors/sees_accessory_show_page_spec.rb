require 'rails_helper'

describe 'visits accessory show page' do
  it 'sees the image, title, description and price for the accessory' do
    accessory1 = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test1', description: 'this is a test1', price: 4, status: 1)
    accessory2 = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test2', description: 'this is a test2', price: 6, status: 1)

    visit bike_shop_path(accessory1.id)
save_and_open_page
    expect(page).to have_content(accessory.title)
    expect(page).to have_content(accessory.description)
    expect(page).to have_content(accessory.price.to_currency)
  end
end