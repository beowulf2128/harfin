class Truthbooksignature < ApplicationRecord
  belongs_to :clubber, :class_name=>:Person, :foreign_key=>:clubber_id
  belongs_to :truthbooksection
  belongs_to :sessionday, optional: true
  has_many   :scores



end
