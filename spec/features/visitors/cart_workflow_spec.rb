require 'rails_helper'

describe 'a visitor accessing the bike shop' do
  it 'add item to cart and sees a flash message for added accessory' do
    accessory = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test1', description: 'this is a test', price: 4)

    visit accessories_path

    click_on 'Add to Cart'

    expect(page).to have_content("You have added #{accessory.title} to your cart.")
  end
  it 'shows cart total quantity' do
    accessory = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test1', description: 'this is a test', price: 4)

    visit accessories_path
 
    expect(page).to have_content('Cart: 0')
 
    click_button 'Add to Cart'

    expect(page).to have_content('Cart: 1')
  end
end
