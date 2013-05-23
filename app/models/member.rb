class Member < ActiveRecord::Base
  attr_accessible :name, :surname, :municipality, :address, :zipcode, :postoffice, :email, :membergroup, :membernumber, :payday
  validates :name, :presence => {:message => "etunimi puuttuu"}
  validates :surname, :presence => true
  validates :municipality, :presence => true
  validates :address, :presence => true
  validates :zipcode, :presence => true
  validates :postoffice, :presence => true
  validates :email, :presence => true
  validates :membergroup, :presence => true
  validates :membernumber, :presence => true
  validates :payday, :presence => true
end