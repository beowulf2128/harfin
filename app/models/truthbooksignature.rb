class Truthbooksignature < ApplicationRecord
  belongs_to :clubber, :class_name=>:Person, :foreign_key=>:clubber_id
  belongs_to :truthbooksection
  has_many   :scores



end
