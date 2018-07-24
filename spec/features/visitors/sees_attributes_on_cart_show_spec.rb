require 'rails_helper'

describe 'a visitor visits /cart' do
  it 'sees all the bike accessory attributes for all accessories added to cart' do
    accessory1 = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test1', description: 'this is a test', price: 4)

    visit accessories_path

    click_button('Add to Cart')
    click_button('Add to Cart')
    click_button('Add to Cart')

    click_on 'View Cart'

    expect(current_path).to eq(cart_path)

    subtotal1 = accessory1.price * 3

    expect(page).to have_content(accessory1.title)
    expect(page).to have_content(accessory1.price)
    expect(page).to have_content("Subtotal: $#{subtotal1}")
    expect(page).to have_content("Total: $#{subtotal1}")
    expect(page).to have_content('Create Account')
    expect(page).to_not have_button('Checkout')
  end
end