# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Wiping data ..."
[Truthbooksection, Truthbook, Sessionday, Registration, Sessionyear, User, Person].each {|c| c.delete_all }

puts "Seeding ..."
puts "reference data"


puts "  - scoretypes"
Scoretype.create!(name: 'Book',             suggested_point_value: 5,active: true)
Scoretype.create!(name: 'Bible',            suggested_point_value: 5,active: true)
Scoretype.create!(name: 'Standard',         suggested_point_value: 5,active: false)
Scoretype.create!(name: 'Section',          suggested_point_value: 15,active: true)
Scoretype.create!(name: 'Training',         suggested_point_value: 30,active: true)
Scoretype.create!(name: 'Final',            suggested_point_value: 30,active: true)
Scoretype.create!(name: 'Friend',           suggested_point_value: 30,active: true)
Scoretype.create!(name: 'ThemeParticipation', suggested_point_value: 30,active: true)

puts "  - 12 truthbooks"
Truthbook.create!([
  {name: '1A', edition: 'rbp1'},
  {name: '1B', edition: 'rbp1'},
  {name: '2A', edition: 'rbp1'},
  {name: '2B', edition: 'rbp1'},
  {name: '3A', edition: 'rbp1'},
  {name: '3B', edition: 'rbp1'},
  {name: '4A', edition: 'rbp1'},
  {name: '4B', edition: 'rbp1'}
])

puts "  - truthbook section reference data"
counter = 1
Truthbook.where(edition: 'rbp1').order(:name).each do |tb|
  if tb.name =~ /A/
    units = %w{1 2 3 4 5 6}
  else
    units = %w{7 8 9 10 11 12}
  end
  units.each do |unit|
    %w{1 2 3 4 5 6 7 8 9 10 Training Final}.each do |section|
      Truthbooksection.create!({
        truthbook_id: tb.id,
        unit: unit,
        section: section,
        sort: counter
      })
      counter += 1
    end # sections
  end # units
end

puts "  - session years"
sy15 = Sessionyear.create!(start_date: Date.parse('August 01, 2015'), end_date: Date.parse('June 01, 2016'), theme: "15-16 theme" )
sy16 = Sessionyear.create!(start_date: Date.parse('August 01, 2016'), end_date: Date.parse('June 01, 2017'), theme: "Don't waste your life" )
sy17 = Sessionyear.create!(start_date: Date.parse('August 01, 2017'), end_date: Date.parse('June 01, 2018'), theme: "Focus on individuals" )
sy18 = Sessionyear.create!(start_date: Date.parse('August 01, 2018'), end_date: Date.parse('June 01, 2019'), theme: "Theme 2018" )
sy19 = Sessionyear.create!(start_date: Date.parse('August 01, 2019'), end_date: Date.parse('June 01, 2020'), theme: "Theme 2019" )
sy20 = Sessionyear.create!(start_date: Date.parse('August 01, 2020'), end_date: Date.parse('June 01, 2021'), theme: "Theme 2020" )

puts "  - session days (calendars)"
puts "    2018-2019"
CalBuilder.build_draft(sy18)
sy18.sessiondays.each {|sd| sd.save! }
puts "    2019-2020"
CalBuilder.build_draft(sy19)
sy19.sessiondays.each {|sd| sd.save! }


puts "  - fake persons"
dan = Person.create!(first_name: 'Dan', middle_name: 'E', last_name: 'And', birthdate: Date.parse('August 01, 1984'), gender: 'm')
meg = Person.create!(first_name: 'Meg', middle_name: 'A', last_name: 'And', birthdate: Date.parse('February 01, 1985'), gender: 'f')
lay = Person.create!(first_name: 'Lay Lay', middle_name: 'J', last_name: 'And', birthdate: Date.parse('August 01, 2012'), gender: 'f')
rey = Person.create!(first_name: 'Rey Rey', middle_name: 'J', last_name: 'And', birthdate: Date.parse('April 01, 2016'), gender: 'f')
joe = Person.create!(first_name: 'Joseph', middle_name: '', last_name: 'Underwood', birthdate: Date.parse('April 02, 2008'), gender: 'm')

puts "  - fake users"
danu = User.create!(email: 'dan@dan.com', password: 'dan', person_id: dan.id)
megu = User.create!(email: 'meg@meg.com', password: 'meg', person_id: meg.id)



puts "  - fake registrations for 2018-19"
reyreg = Registration.create!(registered: true, reg_type: 'Clubber', group_assignment: '3-5s',    person: rey, sessionyear: sy18 )
layreg = Registration.create!(registered: true, reg_type: 'Clubber', group_assignment: '1st-6th', person: lay, sessionyear: sy18 )
joereg = Registration.create!(registered: true, reg_type: 'Clubber', group_assignment: '1st-6th', person: joe, sessionyear: sy18 )

puts "  - fake 2A scorecard rand) for Lay, 1st 10 club nights in 2018"
a2 = Truthbook.find_by_name '2A'
tb_secs = a2.truthbooksections.sorted.limit(50).to_a
sy18.sessiondays.sorted.club_nights.limit(10).each do |sd|
  # Attendances
  att = Attendance.create!({
    attender: lay,
    sessionday: sd,
    recorded_by: dan
  })
  Score.create_book_bible_score_for(lay, dan, att)


  # TB Signas
  signas_cnt = rand(4) # 0 to 4 signas each night
  loop_secs = tb_secs.shift(signas_cnt)
  loop_secs.each do |tb_sec| # grab the 1st X secs, loop
    Truthbooksignature.create!({
      clubber_id: lay.id,
      signed_by_user_id: danu.id,
      signed_date: sd.sd_date,
      truthbooksection_id: tb_sec.id
    })
    Score.create_truthbooksignature_score_for(lay, dan, tb_sec.section_type, att)

  end # tb_secs
end

lay_friend_att = lay.attendances_in(sy18).third
lay_friend_score = Score.create_friend_score_for(lay, dan, lay_friend_att) # just for fun
=begin
Comment.create!({
  comment
})
=end
