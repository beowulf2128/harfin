class Registration < ApplicationRecord
  belongs_to :person
  belongs_to :sessionyear

  validates :person_id, :sessionyear_id, presence: true
  validates :group_assignment, inclusion: {in: ['3-5s', '1st-6th'] }

end
