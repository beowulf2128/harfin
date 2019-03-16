class Attendance < ApplicationRecord
  belongs_to :attender, :class_name=>:Person, :foreign_key=>:attender_id
  belongs_to :sessionday, :optional=>true
  belongs_to :recorded_by, :class_name=>:Person, :foreign_key=>:recorded_by_id
  has_many   :scores
end
