module ApplicationHelper

  def num_to_pc(num)
    number_to_percentage(num *100, :precision => 0)
  end

  # Add up Book/Bible/section/all scores
  def accum_line_pts(line_data)
    pts = 0
    line_data.each do |score_type, scores| # key, val
      pts += scores.sum {|score| score.point_value }
    end
    pts
  end

  def book_bible_att(line_data)
    ld = line_data
    s = []
    s << ld['Book'].first.out  if ld['Book'].present?
    s << ld['Bible'].first.out if ld['Bible'].present?
    s << ld['Attendance'].first.out if ld['Attendance'].present?
    s.join(' ')
  end

  def tb_signas(line_data)
    ld = line_data
    s = []
    s << ld['Section'].map(&:out)  if ld['Section'].present?
    s << ld['Training'].map(&:out)  if ld['Training'].present?
    s << ld['Final'].map(&:out)  if ld['Final'].present?
    s.join(' ')
  end

  def other_scores(line_data)
    ld = line_data
    s = []
    s << ld['Friend'].map(&:out)  if ld['Friend'].present?
    s << ld['ThemeParticipation'].map(&:out)  if ld['ThemeParticipation'].present?
    s << ld['Team'].map(&:out)  if ld['Team'].present?
    s.join(' ')
  end

  def team_color(person)
    color = person.current_registration.team_name
    "<span class='#{color.downcase}-team'>#{color} Team</span>".html_safe
  end

end
