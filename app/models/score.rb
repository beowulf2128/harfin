class Score < ApplicationRecord
  belongs_to :score_type
  belongs_to :attendance
  belongs_to :clubber, :class_name=>:Person, :foreign_key=>:clubber_id
  belongs_to :recorded_by
  belongs_to :recorded_by, :class_name=>:Person, :foreign_key=>:attender_id
end
