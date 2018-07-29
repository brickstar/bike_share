require 'rails_helper'

describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
  end

  describe 'relationships' do
    it { should have_many(:orders) }
  end

  describe 'roles' do
    it 'can be created as an admin' do

      user = User.create(first_name: 'pearl',
                         last_name: 'girl',
                         street: '9th ave',
                         city: 'denver',
                         state: 'CO',
                         zip_code: '12345',
                         email: 'pearl@pearl.com',
                         password: 'lovelove',
                         role: 1)

      expect(user.role).to eq('admin')
      expect(user.admin?).to eq(true)
    end
  end

    it 'can be created as a default user' do
      user = User.create!(first_name: 'heidi',
                         last_name: 'b',
                         street: '9th ave',
                         city: 'denver',
                         state: 'CO',
                         zip_code: '12345',
                         email: 'heidi@heidi.com',
                         password: 'lovelove',
                         role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to eq(true)
  end
end
