require 'rails_helper'

describe OrderAccessory, type: :model do
  describe "validations" do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:order_id) }
    it { should validate_presence_of(:accessory_id) }
  end

  describe "relationships" do
    it { should belong_to(:order) }
    it { should belong_to(:accessory) }
  end

end
