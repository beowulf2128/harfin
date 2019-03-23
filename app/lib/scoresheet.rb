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

end
