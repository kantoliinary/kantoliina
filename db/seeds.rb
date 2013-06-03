# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.create!([login: 'admin', password: 'qwerty123'])
Partner.create!([login: 'partner', password: 'qwerty123'])
Membergroup.create!([groupname: 'Varsinainen jäsen', fee: 10])
Membergroup.create!([groupname: 'Perhejäsen', fee: 5])
Membergroup.create!([groupname: 'Ainaisjäsen', fee: 100])
Membergroup.create!([groupname: 'Kannatusjäsen', fee: 30])
Membergroup.create!([groupname: 'Yhteisöjäsen', fee: 50])

