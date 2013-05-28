require 'faker'

FactoryGirl.define do
  factory :member do |f|
    f.id "1"
    f.firstnames "John"
    f.surname "Doe"
    f.municipality "f"
    f.zipcode "00540"
    f.address "Street 7"
    f.postoffice "Helsinki"
    f.email "sadasdsa@com.cocm"
    f.membergroup "varsinaisjasen"
    f.membernumber "333"
    f.expirationdate "12.02.2011"
    f.membership "true"

  end
  factory :invalid_member, parent: :member do |f|
    f.name nil
  end

end

