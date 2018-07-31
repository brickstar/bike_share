require 'rails_helper'

describe 'a visitor accessing the bike shop' do
  it 'add item to cart and sees a flash message for added accessory' do
    accessory = Accessory.create(image_url: 'https://robohash.org/1', title: 'test1', description: 'this is a test', price: 4)

    visit accessories_path
    click_on 'Add to Cart'

    expect(page).to have_content("You have added #{accessory.title} to your cart.")
  end

  it 'shows cart total quantity' do
    accessory = Accessory.create(image_url: 'https://robohash.org/1', title: 'test1', description: 'this is a test', price: 4)

    visit accessories_path

    within('nav') do
      expect(page).to have_content('0')
    end

    click_button 'Add to Cart'

    within('nav') do
      expect(page).to have_content('1')
    end
  end

  it 'can click a button to remove an item from the cart' do
    accessory = Accessory.create(image_url: 'https://robohash.org/1', title: 'test1', description: 'this is a test', price: 4)

    visit accessories_path

    click_button 'Add to Cart'

    visit cart_path

    expect(page).to have_button('Remove Accessory')
    within('nav') do
      expect(page).to have_content('1')
    end

    click_button 'Remove Accessory'

    within('nav') do
      expect(page).to have_content('0')
    end
    expect(page).to_not have_content(accessory.price)
    expect(page).to have_content("Successfully removed #{accessory.title} from your cart.")

    click_on accessory.title

    expect(current_path).to eq(accessory_path(accessory))
  end

  it 'can click a button to add or remove 1 to the quantity' do
    accessory = Accessory.create(image_url: 'https://robohash.org/1', title: 'test1', description: 'this is a test', price: 4)

    visit accessories_path

    click_button 'Add to Cart'
    click_button 'Add to Cart'

    visit cart_path

    expect(page).to have_button('Increase QTY')
    expect(page).to have_button('Decrease QTY')
    expect(page).to have_content('2')
    expect(page).to have_content('$8.00')
    click_button 'Increase QTY'
    expect(page).to have_content('3')
    expect(page).to have_content('$12.00')
    click_button 'Decrease QTY'
    expect(page).to have_content('2')
    expect(page).to have_content('$8.00')
    expect(page).to have_content('Total: $8.00')
  end

  it 'redirected to login page when you trying to check out' do
    accessory = Accessory.create(image_url: 'https://robohash.org/1', title: 'test1', description: 'this is a test', price: 4)

    visit accessories_path

    click_button 'Add to Cart'
    click_button 'Add to Cart'

    visit cart_path
    click_on 'Checkout'

    expect(current_path).to eq(login_path)
  end
end
