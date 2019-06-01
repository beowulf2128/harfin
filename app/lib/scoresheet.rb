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
        points: s.suggested_point_value
      })
    else
      return OpenStruct.new({
        name: s.out,
        type: s.section_type,
        points: s.scoretype.suggested_point_value
      })
    end
  end
end
