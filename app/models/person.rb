class Person < ApplicationRecord

  has_one    :user
  has_many   :registrations

  scope :sorted, lambda { order('last_name, first_name') }

  def name_lf
    [last_name, first_name].delete_if{|n| n.blank?}.join(', ')
  end
  def name_fl
    [first_name, last_name].delete_if{|n| n.blank?}.join(' ')
  end

end
