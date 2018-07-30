require 'rails_helper'

describe 'a visitor' do
  describe 'visiting any page' do
    it 'should see a nav bar with a Home button that links to the root page' do
      visit stations_path
      within('nav') do
        click_on 'Bikeshare'
      end

      expect(current_path).to eq(root_path)
    end
  end
end
