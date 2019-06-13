class User < ApplicationRecord

  has_secure_password
  validates_uniqueness_of :email

  belongs_to :person
  has_many :roles_users
  has_many :roles, through: :roles_users

  def privileges
    @privileges ||= Privilege.joins(roles: :roles_users).where(roles_users: {user_id: self.id})
  end

  # priv_name - sym or string
  def has_priv?(priv_name)
    privileges.find {|p| p.name.to_s == priv_name.to_s}.present?
  end
end
