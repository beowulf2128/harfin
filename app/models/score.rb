class Score < ApplicationRecord
  belongs_to :scoretype
  belongs_to :sessionday, optional: true
  belongs_to :clubber, :class_name=>:Person, :foreign_key=>:clubber_id, optional: true
  belongs_to :recorded_by, :class_name=>:Person, :foreign_key=>:recorded_by_id
  belongs_to :truthbooksignature, optional: true

  validates_associated :clubber
  validates :point_value, numericality: {only_integer: true}

  # For seed data
  def self.create_book_bible_att_score_for(clubber_person, recorded_by_person, sessionday, score_date=nil)
    transaction do
      [Scoretype.book, Scoretype.bible, Scoretype.attendance].each do |st|
        Score.create!({
          clubber: clubber_person,
          point_value: st.suggested_point_value,
          scoretype: st,
          recorded_by: recorded_by_person,
          sessionday: sessionday
        })
      end # scoretypes
    end # transaction
  end

  # section_type - one of Section, Training, Final
  def self.create_truthbooksignature_score_for(clubber_person, rec_by_person, tb_signa,
                                                sessionday=nil, score_date=nil)

    section_type = tb_signa.truthbooksection.section_type
    if section_type !~ /Section|Training|Final/
      raise "section_type must be one of [Section, Training, Final]. Got: #{section_type}"
    end
    st = Scoretype.find_by_name(section_type)
    Score.create!({
      clubber: clubber_person,
      point_value: st.suggested_point_value,
      scoretype: st,
      recorded_by: rec_by_person,
      sessionday: sessionday,
      truthbooksignature: tb_signa
    })

  end

  def self.create_friend_score_for(clubber_person, rec_by_person, sessionday)
    st = Scoretype.find_by_name('Friend')
    Score.create!({
      clubber: clubber_person,
      point_value: st.suggested_point_value,
      scoretype: st,
      recorded_by: rec_by_person,
      sessionday: sessionday
    })
  end

  def self.create_team_score(team_name, point_value, sessionday, comment, rec_by_person)
    st = Scoretype.find_by_name('Team')
    s = Score.create!({
      team_name: team_name,
      point_value: point_value,
      scoretype: st,
      #score_date: score_date,
      sessionday: sessionday,
      recorded_by: rec_by_person,
    })
    # TODO create comment for this score
  end

end
