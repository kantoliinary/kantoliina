#encoding: UTF-8
require 'faker'

FactoryGirl.define do
  factory :membergroup do |f|
    f.id "1"
    f.groupname "Varsinainen jasen"
    f.fee "10.00"
  end
end