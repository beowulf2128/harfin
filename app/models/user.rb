class User < ApplicationRecord

  has_secure_password
  validates_uniqueness_of :email

  has_one :person
  has_many :registrations

end
