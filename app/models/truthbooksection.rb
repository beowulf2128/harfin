class Truthbooksection < ApplicationRecord
  belongs_to :truthbook
  def out
    "#{truthbook.name} #{unit}-#{section}"
  end
end
