require 'faker'

FactoryGirl.define do
  factory :member do |f|
    f.name "John"
    f.surname "Doe"
    f.municipality "f"
    f.zipcode "00540"
    f.address "Street 7"
    f.postoffice "Helsinki"
    f.email "sadasdsa@com.cocm"
    f.membergroup "varsinaisjasen"
    f.membernumber "333"
    f.payday "12.02.2011"

  end
end

