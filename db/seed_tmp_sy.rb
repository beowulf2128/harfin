puts "Seeding a temp sessionyear"

first = Time.now
last = 2.weeks.from_now


sy = Sessionyear.create!(start_date: first, end_date: last, theme: "Test #{first.to_s(:mdy)}-#{last.to_s(:mdy)}" )

days = (first.to_date..last.to_date)
days.each do |day|
  sy.sessiondays.create!({
    sd_date: day,
    is_club_night: true
  })
end
