# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[Registration, Sessionyear, User, Person].each {|c| c.delete_all }

dan = Person.create!(first_name: 'Dan', middle_name: 'E', last_name: 'And', birthdate: Date.parse('August 01, 1984'), gender: 'm')
meg = Person.create!(first_name: 'Meg', middle_name: 'A', last_name: 'And', birthdate: Date.parse('February 01, 1985'), gender: 'f')
lay = Person.create!(first_name: 'Lay Lay', middle_name: 'J', last_name: 'And', birthdate: Date.parse('August 01, 2012'), gender: 'f')
rey = Person.create!(first_name: 'Rey Rey', middle_name: 'J', last_name: 'And', birthdate: Date.parse('April 01, 2016'), gender: 'f')
joe = Person.create!(first_name: 'Joseph', middle_name: '', last_name: 'Underwood', birthdate: Date.parse('April 02, 2008'), gender: 'm')

danu = User.create!(email: 'dan@dan.com', password: 'dan', person_id: dan.id)
megu = User.create!(email: 'meg@meg.com', password: 'meg', person_id: meg.id)

sy17 = Sessionyear.create!(start_date: Date.parse('August 01, 2017'), end_date: Date.parse('June 01, 2018'), theme: "Focus on individuals" )
sy16 = Sessionyear.create!(start_date: Date.parse('August 01, 2016'), end_date: Date.parse('June 01, 2017'), theme: "Don't waste your life" )
sy15 = Sessionyear.create!(start_date: Date.parse('August 01, 2015'), end_date: Date.parse('June 01, 2016'), theme: "15-16 theme" )

layreg = Registration.create!(registered: true, reg_type: 'Clubber', group_assignment: '3-5s', person: lay, sessionyear: sy16 )
joereg = Registration.create!(registered: true, reg_type: 'Clubber', group_assignment: '1st-6th', person: joe, sessionyear: sy16 )


