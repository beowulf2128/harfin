puts "Seeding a temp sessionyear"

first = Time.now
last = 4.weeks.from_now


sy = Sessionyear.create!(start_date: first, end_date: last, theme: "Tmp NO CLUB DAYS #{first.to_s(:mdy)}-#{last.to_s(:mdy)}" )

days = (first.to_date..last.to_date)
days.each do |day|
  sy.sessiondays.create!({
    sd_date: day,
    is_club_night: false
  })
end
