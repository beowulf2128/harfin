# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require './db/seed_helper'

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

puts "  - Privileges "
rps = YAML::load_file Rails.root.join('db','data','roles_privs.yml')
SeedHelper.create_from_attrs_ary_once!(Privilege, rps["privileges"])

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
