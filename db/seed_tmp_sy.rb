puts "Seeding a temp sessionyear"

first = Time.now
last = 4.weeks.from_now
days = (first.to_date..last.to_date)

sy_none = Sessionyear.create!(start_date: first, end_date: last, theme: "Tmp NO CLUB DAYS #{first.to_s(:mdy)}-#{last.to_s(:mdy)}" )
days.each do |day|
  sy_none.sessiondays.create!({
    sd_date: day,
    is_club_night: false
  })
end
puts " - added sy with NO club days: #{first} thru #{last}"

sy_all = Sessionyear.create!(start_date: first, end_date: last, theme: "Tmp ALL CLUB DAYS #{first.to_s(:mdy)}-#{last.to_s(:mdy)}" )
days.each do |day|
  sy_all.sessiondays.create!({
    sd_date: day,
    is_club_night: true
  })
end
puts " - added sy with ALL club days: #{first} thru #{last}"
