require 'rails_helper'

describe Accessory, type: :model do
  describe 'validations' do
    it {should validate_uniqueness_of(:title)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:status)}
    it {should validate_presence_of(:image_url)}
    it {should validate_numericality_of(:price).
                  is_greater_than(0)}
  end
end
