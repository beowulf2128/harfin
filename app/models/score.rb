class Score < ApplicationRecord
  belongs_to :scoretype
  belongs_to :attendance
  belongs_to :clubber, :class_name=>:Person, :foreign_key=>:clubber_id
  belongs_to :recorded_by, :class_name=>:Person, :foreign_key=>:recorded_by_id
  #belongs_to :truthbooksignature # TODO make this optional relationship

  def self.create_book_bible_score_for(clubber_person, recorded_by_person, attendance=nil, score_date=nil)
    transaction do
      [Scoretype.book, Scoretype.bible].each do |st|
        Score.create!({
          clubber: clubber_person,
          point_value: st.suggested_point_value,
          scoretype: st,
          recorded_by: recorded_by_person,
          attendance: attendance
        })
      end # scoretypes
    end # transaction
  end

  # section_type - one of Section, Training, Final
  def self.create_truthbooksignature_score_for(clubber_person, rec_by_person, section_type,
                                                attendance=nil, score_date=nil)
    if section_type !~ /Section|Training|Final/
      raise "section_type must be one of [Section, Training, Final]. Got: #{section_type}"
    end
    st = Scoretype.find_by_name(section_type)
    Score.create!({
      clubber: clubber_person,
      point_value: st.suggested_point_value,
      scoretype: st,
      recorded_by: rec_by_person,
      attendance: attendance
    })

  end

  def self.create_friend_score_for(clubber_person, rec_by_person, attendance)
    st = Scoretype.find_by_name('Friend')
    Score.create!({
      clubber: clubber_person,
      point_value: st.suggested_point_value,
      scoretype: st,
      recorded_by: rec_by_person,
      attendance: attendance
    })
  end

end
