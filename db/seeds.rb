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
Member.create!([firstnames: "Kalle", surname: "Lammenoja", email: "kalle.lammenoja@gmail.com", municipality: "Vihti", address: "Vihdintie 8", country: "Suomi", zipcode: "43211", postoffice: "s-market", membergroup_id: "1", membernumber: "10000", active: true, membershipyear: "2013", paymentstatus: false, invoicedate: nil, reminderdate: nil, lender: false, support: false, info: ""])
Member.create!([firstnames: "Eero", surname: "Laine", email: "eerovolaine@yahoo.com", municipality: "Helsinki", address: "Stadintie 3", country: "Suomi", zipcode: "00040", postoffice: "k-market", membergroup_id: "1", membernumber: "10001", active: true, membershipyear: "2013", paymentstatus: false, invoicedate: nil, reminderdate: nil, lender: false, support: false, info: ""])
Member.create!([firstnames: "Taneli", surname: "Virkkala", email: "taneli.wirkkala@gmail.com", municipality: "Vantaa", address: "Tikkurilax 45", country: "Suomi", zipcode: "00140", postoffice: "lidl", membergroup_id: "1", membernumber: "10002", active: true, membershipyear: "2013", paymentstatus: false, invoicedate: nil, reminderdate: nil, lender: false, support: false, info: ""])
Member.create!([firstnames: "Jamox", surname: "Bighouse", email: "jarmo.isotalo@gmail.com", municipality: "Sipoo", address: "Landentie 32", country: "Suomi", zipcode: "00240", postoffice: "spar", membergroup_id: "1", membernumber: "10003", active: true, membershipyear: "2013", paymentstatus: false, invoicedate: nil, reminderdate: nil, lender: false, support: false, info: ""])
Member.create!([firstnames: "Timo", surname: "Pitkänen", email: "timo.o.pitkanen@cs.helsinki.fi", municipality: "Stadi", address: "Keskuskatu 3", country: "Suomi", zipcode: "00040", postoffice: "r-kiska", membergroup_id: "1", membernumber: "10004", active: true, membershipyear: "2013", paymentstatus: false, invoicedate: nil, reminderdate: nil, lender: false, support: false, info: ""])
Member.create!([firstnames: "Tero", surname: "Kujala", email: "tero.s.kujala@gmail.com", municipality: "Stadi", address: "Toinenkatu 4", country: "Suomi", zipcode: "00040", postoffice: "siwa", membergroup_id: "1", membernumber: "10005", active: true, membershipyear: "2013", paymentstatus: false, invoicedate: nil, reminderdate: nil, lender: false, support: false, info: ""])
Member.create!([firstnames: "Urbuz", surname: "Korb", email: "kalle.lammenoja@gmail.com", municipality: "Aarhan", address: "Karkhaz 8", country: "Andorra", zipcode: "74823", postoffice: "kzzz", membergroup_id: "2", membernumber: "10006", active: true, membershipyear: "2013", paymentstatus: false, invoicedate: nil, reminderdate: nil, lender: false, support: false, info: ""])
Member.create!([firstnames: "Haxan", surname: "Varzov", email: "eerovolaine@yahoo.com", municipality: "Paris", address: "Feral 3", country: "France", zipcode: "04325", postoffice: "dunno", membergroup_id: "1", membernumber: "10007", active: true, membershipyear: "2013", paymentstatus: false, invoicedate: nil, reminderdate: nil, lender: false, support: false, info: ""])
Member.create!([firstnames: "Ozor", surname: "Hahha", email: "taneli.wirkkala@gmail.com", municipality: "London", address: "Haughwan 55", country: "United Kingdom", zipcode: "43440", postoffice: "carhouse", membergroup_id: "1", membernumber: "10008", active: true, membershipyear: "2013", paymentstatus: false, invoicedate: nil, reminderdate: nil, lender: false, support: false, info: ""])
Member.create!([firstnames: "Kanto", surname: "Piina", email: "jarmo.isotalo@gmail.com", municipality: "Boxer", address: "Testcode 32", country: "Germany", zipcode: "00241", postoffice: "franken", membergroup_id: "2", membernumber: "10009", active: true, membershipyear: "2013", paymentstatus: false, invoicedate: nil, reminderdate: nil, lender: false, support: false, info: ""])
Member.create!([firstnames: "Testi", surname: "Testaaja", email: "timo.o.pitkanen@cs.helsinki.fi", municipality: "testi", address: "Tewstikatu 3", country: "Suomi", zipcode: "44440", postoffice: "testkaup", membergroup_id: "2", membernumber: "10010", active: true, membershipyear: "2013", paymentstatus: false, invoicedate: nil, reminderdate: nil, lender: false, support: false, info: ""])
Member.create!([firstnames: "Maija", surname: "Mehiläinen", email: "tero.s.kujala@gmail.com", municipality: "Keko", address: "Keonkatu 4", country: "Uganda", zipcode: "00440", postoffice: "Hunaja", membergroup_id: "2", membernumber: "10011", active: true, membershipyear: "2013", paymentstatus: false, invoicedate: nil, reminderdate: nil, lender: false, support: false, info: ""])



