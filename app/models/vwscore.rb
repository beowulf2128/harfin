class Vwscore < ActiveRecord::Base
  belongs_to :clubber, :class_name=>:Person, :foreign_key=>:clubber_id
  belongs_to :sessionyear

  scope :ordered, ->{ order('score_date DESC') }

  def display_date
    score_date || sessionday_date
  end

  def out
    #if %w{Book Bible Attendance}.include?(score_type_name)
    if is_truthbooksignature?
      "#{Truthbooksection.formatted(truthbook_name, truthbook_unit, truthbook_section)}: #{point_value} "
    else
      "#{score_type_name}: #{point_value}"
    end
  end

  def self.scores_for(person, sessionyear)
    Vwscore.where(["clubber_id = ? or team_name = ?",
                    person.id, person.current_registration.team_name]).
            where(sessionyear: sessionyear).ordered
  end

end
