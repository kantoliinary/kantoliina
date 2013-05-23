require 'faker'

FactoryGirl.define do
  factory :member do |f|
    f.name "John"
    f.surname "Doe"
    f.municipality "f"
    f.zipcode "00540"
    f.address "Street 7"
    f.postoffice "Helsinki"
    f.email "john@doe.com"
    f.membergroup "varsinaisjasen"
    f.membernumber "333"
    f.payday "21/12/12"

  end
end

