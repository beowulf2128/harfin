class Person < ApplicationRecord

  scope :sorted, lambda { order('last_name, first_name') }

  def name_lf
    [last_name, first_name].delete_if{|n| n.blank?}.join(', ')
  end
end
