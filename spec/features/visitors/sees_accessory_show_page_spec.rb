require 'rails_helper'

describe 'visits accessory show page' do
  it 'sees the image, title, description and price for the accessory' do
    accessory1 = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test1', description: 'this is a test1', price: 4, status: 1)
    accessory2 = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test2', description: 'this is a test2', price: 6, status: 1)

    visit accessory_path(accessory1)

    expect(page).to have_content(accessory1.title)
    expect(page).to have_content(accessory1.description)
    expect(page).to have_content(accessory1.price)
  end
end