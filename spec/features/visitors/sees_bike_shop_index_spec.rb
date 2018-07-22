require 'rails_helper'

describe 'visits bike shop' do
  it 'sees at least 12 bike accessories' do
    accessory1 = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test1', description: 'this is a test', price: 4, status: 1)
    accessory2 = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test2', description: 'this is a test', price: 4, status: 1)
    accessory3 = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test3', description: 'this is a test', price: 4, status: 1)
    accessory4 = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test4', description: 'this is a test', price: 4, status: 1)
    accessory5 = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test5', description: 'this is a test', price: 4, status: 1)
    accessory6 = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test6', description: 'this is a test', price: 4, status: 1)
    accessory7 = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test7', description: 'this is a test', price: 4, status: 1)
    accessory8 = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test8', description: 'this is a test', price: 4, status: 1)
    accessory9 = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test9', description: 'this is a test', price: 4, status: 1)
    accessory10 = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test10', description: 'this is a test', price: 4, status: 1)
    accessory11 = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test11', description: 'this is a test', price: 4, status: 1)
    accessory12 = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test12', description: 'this is a test', price: 4, status: 1)
    accessory13 = Accessory.create(image_url: 'www.insertrealpics.com', title: 'test13', description: 'this is a test', price: 4, status: 1)

    visit accessories_path

    expect(page).to have_content(accessory1.title)
    within("#accessory_#{accessory1.id}") do
      expect(page).to have_content('Add to Cart')
    end
    expect(page).to have_content(accessory2.title)
    expect(page).to have_content(accessory3.title)
    expect(page).to have_content(accessory4.title)
    expect(page).to have_content(accessory5.title)
    expect(page).to have_content(accessory6.title)
    expect(page).to have_content(accessory7.title)
    expect(page).to have_content(accessory8.title)
    expect(page).to have_content(accessory9.title)
    expect(page).to have_content(accessory10.title)
    expect(page).to have_content(accessory11.title)
    within("#accessory_#{accessory11.id}") do
      expect(page).to have_content('Add to Cart')
    end
    expect(page).to have_content(accessory12.title)
    expect(page).to_not have_content(accessory13.title)
    expect(page).to have_content('Next')
  end
end
