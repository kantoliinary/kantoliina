class Member < ActiveRecord::Base
  attr_accessible :name, :surname, :municipality, :address, :zipcode, :postoffice, :email, :membergroup, :membernumber, :payday
  validates :name, :presence => { :message => "Ei voi olla tyhja" }
  validates :surname, :presence => true
  validates :municipality, :presence => true
  validates :address, :presence => true
  validates :zipcode, :length => {:minimum => 5, :maximum => 5}, :numericality => {:only_integer => true}, :presence => true
  validates :postoffice, :presence => true
  validates :email, :presence => true,
            :format => {
                :with    => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                :message => "Sahkopostin muoto on vaara"}
  validates :membergroup, :presence => true
  validates :membernumber, :numericality => {:only_integer => true}, :presence => true
  validates :payday, :presence => true
end