class User < ApplicationRecord
  has_secure_password

  validates_presence_of :first_name, :last_name, :street, :city, :state, :zip_code
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true

  enum role: ['default', 'admin']
end
