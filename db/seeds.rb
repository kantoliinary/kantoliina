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
Member.create!([firstnames: "Kalle", surname: "TestiLammenoja", email: "kalle.lammenoja@gmail.com", municipality: "Vihti", address: "Vihdintie 8", country: "Suomi", zipcode: "43211", postoffice: "Vihti", membergroup_id: "1", membernumber: "10000", active: true, membershipyear: "2013", paymentstatus: false, invoicedate: nil, reminderdate: nil, lender: false, support: false, info: ""])
Member.create!([firstnames: "Eero", surname: "TestiLaine", email: "eerovolaine@yahoo.com", municipality: "Helsinki", address: "Stadintie 3", country: "Suomi", zipcode: "00040", postoffice: "Helsinki", membergroup_id: "1", membernumber: "10001", active: true, membershipyear: "2013", paymentstatus: false, invoicedate: nil, reminderdate: nil, lender: false, support: false, info: ""])
Member.create!([firstnames: "Taneli", surname: "TestiVirkkala", email: "taneli.wirkkala@gmail.com", municipality: "Vantaa", address: "Tikkurilax 45", country: "Suomi", zipcode: "00140", postoffice: "Tikkurila", membergroup_id: "1", membernumber: "10002", active: true, membershipyear: "2013", paymentstatus: false, invoicedate: nil, reminderdate: nil, lender: false, support: false, info: ""])
Member.create!([firstnames: "Jarmo", surname: "TestiIsotalo", email: "jarmo.isotalo@gmail.com", municipality: "Sipoo", address: "Sipoontie 32", country: "Suomi", zipcode: "00240", postoffice: "Sipoo", membergroup_id: "1", membernumber: "10003", active: true, membershipyear: "2013", paymentstatus: false, invoicedate: nil, reminderdate: nil, lender: false, support: false, info: ""])
Member.create!([firstnames: "Timo", surname: "TestiPitkänen", email: "timo.o.pitkanen@cs.helsinki.fi", municipality: "Stadi", address: "Keskuskatu 3", country: "Suomi", zipcode: "00040", postoffice: "Helsinki", membergroup_id: "1", membernumber: "10004", active: true, membershipyear: "2013", paymentstatus: false, invoicedate: nil, reminderdate: nil, lender: false, support: false, info: ""])
Member.create!([firstnames: "Tero", surname: "TestiKujala", email: "tero.s.kujala@gmail.com", municipality: "Stadi", address: "Toinenkatu 4", country: "Suomi", zipcode: "00040", postoffice: "Helsinki", membergroup_id: "1", membernumber: "10005", active: true, membershipyear: "2013", paymentstatus: false, invoicedate: nil, reminderdate: nil, lender: false, support: false, info: ""])
Member.create!([firstnames: "Filippa", surname: "TestiForte", email: "kalle.lammenoja@gmail.com", municipality: "Rome", address: "Via de Aleppo 8", country: "Italy", zipcode: "74823", postoffice: "Rome", membergroup_id: "2", membernumber: "10006", active: true, membershipyear: "2013", paymentstatus: false, invoicedate: nil, reminderdate: nil, lender: false, support: false, info: ""])
Member.create!([firstnames: "Jeanne-Marie", surname: "TestiBeaumarlet", email: "eerovolaine@yahoo.com", municipality: "Paris", address: "Rue de Voltaire", country: "France", zipcode: "04325", postoffice: "Paris", membergroup_id: "1", membernumber: "10007", active: true, membershipyear: "2013", paymentstatus: false, invoicedate: nil, reminderdate: nil, lender: false, support: false, info: ""])
Member.create!([firstnames: "Sharon", surname: "TestiCarter", email: "taneli.wirkkala@gmail.com", municipality: "London", address: "10 Oxford Street", country: "United Kingdom", zipcode: "43440", postoffice: "London", membergroup_id: "1", membernumber: "10008", active: true, membershipyear: "2013", paymentstatus: false, invoicedate: nil, reminderdate: nil, lender: false, support: false, info: ""])
Member.create!([firstnames: "Kanto", surname: "TestiHauptmann", email: "jarmo.isotalo@gmail.com", municipality: "Essen", address: "Barenstrasse 8", country: "Germany", zipcode: "00241", postoffice: "Herzburg", membergroup_id: "2", membernumber: "10009", active: true, membershipyear: "2013", paymentstatus: false, invoicedate: nil, reminderdate: nil, lender: false, support: false, info: ""])
Member.create!([firstnames: "Teija", surname: "TestiTestaaja", email: "timo.o.pitkanen@cs.helsinki.fi", municipality: "testi", address: "Tewstikatu 3", country: "Suomi", zipcode: "44440", postoffice: "test", membergroup_id: "2", membernumber: "10010", active: true, membershipyear: "2013", paymentstatus: false, invoicedate: nil, reminderdate: nil, lender: false, support: false, info: ""])
Member.create!([firstnames: "Maija", surname: "TestiMehilä", email: "tero.s.kujala@gmail.com", municipality: "Espoo", address: "Suvelantie 4", country: "Suomi", zipcode: "00440", postoffice: "Suvela", membergroup_id: "2", membernumber: "10011", active: true, membershipyear: "2013", paymentstatus: false, invoicedate: nil, reminderdate: nil, lender: false, support: false, info: ""])



