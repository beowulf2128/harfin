class Registration < ApplicationRecord

  RED = 'Red'
  BLUE = 'Blue'

  belongs_to :person
  belongs_to :sessionyear

  validates :person_id, :sessionyear_id, presence: true
  validates :group_assignment, inclusion: {in: ['3-5s', '1st-6th'] }
  validates :team_name, inclusion: {in: [RED, BLUE] }

  def self.for_person_in(person, sessionyear)
    person.registrations.where(sessionyear: sessionyear)
  end

end
