module ApplicationHelper
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

end
