# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.create!([username: 'admin', password: 'qwerty123', email: "kantoliinatesti@gmail.com"])
Partner.create!([username: 'partner', password: 'qwerty123'])
Membergroup.create!([name: 'Varsinainen jäsen', fee: 10, onetimefee: false])
Membergroup.create!([name: 'Perhejäsen', fee: 5, onetimefee: false])
Membergroup.create!([name: 'Ainaisjäsen', fee: 100, onetimefee: true])
Membergroup.create!([name: 'Kannatusjäsen', fee: 30, onetimefee: false])
Membergroup.create!([name: 'Yhteisöjäsen', fee: 50, onetimefee: false])


