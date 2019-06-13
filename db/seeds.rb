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
Scoretype.create!(name: 'Attendance',       suggested_point_value: 5,active: true)
Scoretype.create!(name: 'Book',             suggested_point_value: 5,active: true)
Scoretype.create!(name: 'Bible',            suggested_point_value: 5,active: true)
Scoretype.create!(name: 'Standard',         suggested_point_value: 5,active: false)
st_sec = Scoretype.create!(name: 'Section',          suggested_point_value: 15,active: true)
st_trn = Scoretype.create!(name: 'Training',         suggested_point_value: 30,active: true)
st_fnl = Scoretype.create!(name: 'Final',            suggested_point_value: 30,active: true)
Scoretype.create!(name: 'Friend',           suggested_point_value: 30,active: true)
Scoretype.create!(name: 'ThemeParticipation', suggested_point_value: 30,active: true)
Scoretype.create!(name: 'Team',             suggested_point_value: 15,active: true)
Scoretype.create!(name: 'StorePurchase',    suggested_point_value: -100,active: true)

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
      st = st_sec
      st = st_trn if section == 'Training'
      st = st_fnl if section == 'Final'
      Truthbooksection.create!({
        truthbook_id: tb.id,
        unit: unit,
        section: section,
        sort: counter,
        scoretype: st
      })
      counter += 1
    end # sections
  end # units
end
# require './20190601024658_add_is_scoretype_id_to_truthbooksection'
# AddIsScoretypeIdToTruthbooksection.fill_scoretype_ids

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
# admins
dan = Person.create!(first_name: 'Dan', middle_name: 'E', last_name: 'And', birthdate: Date.parse('August 01, 1984'), gender: 'm')
meg = Person.create!(first_name: 'Meg', middle_name: 'A', last_name: 'And', birthdate: Date.parse('February 01, 1985'), gender: 'f')
# clubbers
lay = Person.create!(first_name: 'Lay Lay', middle_name: 'J', last_name: 'And', birthdate: Date.parse('August 01, 2012'), gender: 'f')
rey = Person.create!(first_name: 'Rey Rey', middle_name: 'J', last_name: 'And', birthdate: Date.parse('April 01, 2016'), gender: 'f')
joe = Person.create!(first_name: 'Joseph', middle_name: '', last_name: 'Und', birthdate: Date.parse('April 02, 2008'), gender: 'm')

lucy = Person.create!(first_name: 'Lucy', middle_name: '', last_name: 'Und', birthdate: Date.parse('April 09, 2008'), gender: 'f')
molly = Person.create!(first_name: 'Molly', middle_name: '', last_name: 'Da', birthdate: Date.parse('April 06, 2008'), gender: 'f')
bruce = Person.create!(first_name: 'Bruce', middle_name: '', last_name: 'Wo', birthdate: Date.parse('April 16, 2013'), gender: 'm')

# leaders
am = Person.create!(first_name: 'Am', middle_name: '', last_name: 'Und', birthdate: Date.parse('April 09, 1980'), gender: 'f')

# parents
kev = Person.create!(first_name: 'Kev', middle_name: '', last_name: 'Und', birthdate: Date.parse('April 02, 1980'), gender: 'm')

# no access
abi = Person.create!(first_name: 'Abi', middle_name: '', last_name: 'Vo', birthdate: Date.parse('April 03, 2006'), gender: 'f')


Am
puts "  - fake users"
danu = User.create!(email: 'dan@dan.com', password: 'dan', person_id: dan.id)
megu = User.create!(email: 'meg@meg.com', password: 'meg', person_id: meg.id)
amu = User.create!(email: 'am@mam.com', password: 'am', person_id: am.id)
kevu = User.create!(email: 'kev@kev.com', password: 'kev', person_id: kev.id)
abiu = User.create!(email: 'abi@abi.com', password: 'abi', person_id: abi.id)

SeedHelper.add_role_to_users('admin', [danu, megu])
SeedHelper.add_role_to_users('leader', [amu])
SeedHelper.add_role_to_users('parent', [kevu])
# no roles for abi !!!!


puts "  - fake registrations for 2018-19"
reyreg = Registration.create!(table_assignment: 3, team_name: 'Blue', registered: true, reg_type: 'Clubber', group_assignment: '3-5s',    person: rey, sessionyear: sy18 )
layreg = Registration.create!(table_assignment: 2, team_name: 'Blue', registered: true, reg_type: 'Clubber', group_assignment: '1st-6th', person: lay, sessionyear: sy18 )
joereg = Registration.create!(table_assignment: 4, team_name: 'Red',  registered: true, reg_type: 'Clubber', group_assignment: '1st-6th', person: joe, sessionyear: sy18 )

puts "  - fake 2A scores rand) for Lay, 1st 10 club nights in 2018"
a2 = Truthbook.find_by_name '2A'
tb_secs = a2.truthbooksections.sorted.limit(50).to_a
sy18.sessiondays.sorted.club_nights.limit(10).each do |sd|

  Score.create_book_bible_att_score_for(lay, dan, sd)

  # TB Signas
  signas_cnt = rand(4) # 0 to 4 signas each night
  loop_secs = tb_secs.shift(signas_cnt)
  loop_secs.each do |tb_sec| # grab the 1st X secs, loop
    tbsigna = Truthbooksignature.create!({
      clubber_id: lay.id,
      truthbooksection_id: tb_sec.id
    })
    Score.create_truthbooksignature_score_for(lay, dan, tbsigna, sd)

  end # tb_secs
end

lay_friend_sd = sy18.sessiondays.third
lay_friend_score = Score.create_friend_score_for(lay, dan, lay_friend_sd) # just for fun

Score.create_team_score('Blue', 30, sy18.sessiondays.fourth,
                          'Won review game', dan)
=begin
Comment.create!({
  comment
})
=end

puts "  - Privileges "
rps = YAML::load_file Rails.root.join('db','data','roles_privs.yml')
SeedHelper.create_from_attrs_ary_once!(rps["privileges"])

puts "  - Roles "
Role.transaction do
  rps["roles"].each do |attrs|
    role_attrs = attrs.except("privs")
    role = SeedHelper.create_from_attrs_once!(Role, role_attrs)
    attrs["privs"].split(',').each do |priv|
      role.privileges << Privilege.find_by_name(priv)
    end
  end
end
