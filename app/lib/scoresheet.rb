# Takes Vwscores data, organizes it for display as a single score sheet
class Scoresheet

  def initialize(vwscores)
    @vwscores = vwscores
    @grouped_by_date = {} # ruby hashes stay in order of insertion
  end

  # A scoresheet line is usually every score that happens during a club night.
  # For non-club night scores, each date stamp is a line
  def lines
    @lines ||= Scoresheet.group_by_date_then_scoretype(@vwscores)
  end

  def self.group_by_date_then_scoretype(vwscores) # assumes scores are sorted by date
    by_date = {}
    vwscores.each do |score|
      key = Utils.date_fmt(score.display_date)
      by_date[key]                         = {} if by_date[key].nil?
      by_date[key][score.score_type_name]  = [] if by_date[key][score.score_type_name].nil?
      by_date[key][score.score_type_name]  << score
    end
    by_date
  end

  def self.avail_bk_bib_att_scores #TODO for a date or club night
    Scoretype.where(name: Scoretype::BBA_TYPES).collect do |st|
      Scoresheet.to_avail(st)
    end
  end

  def self.avail_section_scores(person)
    person.next_truthbook_sections.collect do |s|
      Scoresheet.to_avail(s)
    end
  end
  def self.avail_other_scores #TODO for a date or club night
    Scoretype.where(name: Scoretype::OTHER_TYPES).collect do |st|
      Scoresheet.to_avail(st)
    end
  end

  def self.to_avail(scoretype_or_truthbooksection)
    s = scoretype_or_truthbooksection
    if s.class == Scoretype
      return OpenStruct.new({
        name: s.name,
        type: s.name,
        points: s.suggested_point_value,
        scoretype_id: s.id
      })
    else
      return OpenStruct.new({
        name: s.out,
        type: s.section_type,
        points: s.scoretype.suggested_point_value,
        truthbooksection_id: s.id
      })
    end
  end

  def self.add_nonsection_scores(for_person, scoretype_id_hashes, sessionday_id, rec_by_person)
    st_ids_to_add = []
    scoretype_id_hashes.each do |id, on_off|
      st_ids_to_add << id if Utils.cb_to_tf(on_off) == true
    end
    # sts_to_del = scoretype_id_hashes.collect {|id, on_off| id if Utils.cb_to_tf(on_off) == false}
    Score.transaction do
      st_ids_to_add.each do |id|
        st = Scoretype.find(id)
        Score.create!({
          clubber: for_person,
          scoretype: st,
          point_value: st.suggested_point_value,
          recorded_by: rec_by_person,
          score_date: Time.now, # TODO now or nil if attendance,
          team_name: nil # for team (non-person) scores
        })
      end
    end
    return ResultMgr.new
  end
end
