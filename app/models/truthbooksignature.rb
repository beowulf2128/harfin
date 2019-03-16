class Truthbooksignature < ApplicationRecord
  belongs_to :clubber, :class_name=>:Person, :foreign_key=>:clubber_id
  belongs_to :signed_by_user, :class_name=>:User, :foreign_key=>:signed_by_user_id
  belongs_to :truthbooksection
  has_many   :scores



end
