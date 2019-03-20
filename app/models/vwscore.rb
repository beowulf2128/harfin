class Vwscore < ActiveRecord::Base
  belongs_to :clubber, :class_name=>:Person, :foreign_key=>:clubber_id
  belongs_to :sessionyear

  scope :ordered, ->{ order('score_date DESC') }

  def self.scores_for(person, sessionyear)
    Vwscore.where(["clubber_id = ? or team_name = ?",
                    person.id, person.current_registration.team_name]).
            where(sessionyear: sessionyear).ordered
  end
end
