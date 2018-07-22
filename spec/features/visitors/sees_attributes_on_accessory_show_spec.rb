require 'rails_helper'

describe 'visits accessory show page' do
  it 'sees the image, title, description and price for the accessory' do
    accessory = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test1', description: 'this is a test1', price: 4, status: 1)

    visit accessory_path(accessory)

    expect(page).to have_content(accessory.title)
    expect(page).to have_content(accessory.description)
    expect(page).to have_content(accessory.price)
  end
  it 'can click a link for add to cart' do
    accessory = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test1', description: 'this is a test1', price: 4, status: 1)

    visit accessory_path(accessory)

    expect(page).to have_content('Add to Cart')
    click_on 'Add to Cart'
  end
end