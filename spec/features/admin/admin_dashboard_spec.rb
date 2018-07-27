require 'rails_helper'

describe 'admin user visits dashboard' do
  describe 'sees a list of all orders' do
    it 'total number of orders for each status' do

      expect(page).to have_content('Ordered')
      expect(page).to have_content('Paid')
      expect(page).to have_content('Cancelled')
      expect(page).to have_content('Completed')
    end

    it 'sees a list for each individual order' do
      # I see a link for each individual order,
      expect(page).to have_link()
    end

    it 'can filter orders to display by each status type' do

      expect(page).to have_content('Ordered')
      expect(page).to have_content('Paid')
      expect(page).to have_content('Cancelled')
      expect(page).to have_content('Completed')
    end

    it 'can see links to transition between statuses' do
    end

    it 'can click \'cancel\' on an order that is \'paid or ordered\'' do
    end

    it 'can click \'mark as paid\' on an order that is marked \'ordered\'' do
    end

    it 'can click \'mark as completed\' on an order that is \'paid\'' do
    end
  end
end
