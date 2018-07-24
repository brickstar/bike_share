require 'rails_helper'

describe 'a visitor accessing the bike shop' do
  it 'add item to cart and sees a flash message for added accessory' do
    accessory = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test1', description: 'this is a test', price: 4)

    visit bike_shop_path

    click_on 'Add to Cart'

    expect(page).to have_content("You have added #{accessory.title} to your cart.")
  end
end
