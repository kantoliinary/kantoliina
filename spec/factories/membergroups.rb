#encoding: UTF-8
require 'faker'

FactoryGirl.define do
  factory :membergroup do |f|
    f.id "1"
    f.name "Varsinainen jasen"
    f.fee "10.00"
    f.onetimefee true
  end

  #factory :invalid_name_membergroup do |f|
  #  f.id "2"
  #  f.name nil
  #  f.fee "jee"
  #end
  #
  #factory :invalid_fee_membergroup do |f|
  #  f.id "3"
  #  f.name "jäsenryhmä"
  #  f.fee "jee"
  #end

end