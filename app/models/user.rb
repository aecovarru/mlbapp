class User < ApplicationRecord
  has_secure_password
  validates :name,     presence: true, length: { maximum: 50 }
  validates :password, length: { minimum: 6 }
end
