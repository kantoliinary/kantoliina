#encoding: UTF-8

##
# The model for a membergroup in the database. Represents the official status a member has in the association.
#
class Membergroup < ActiveRecord::Base
  attr_accessible :name, :fee, :onetimefee
  has_many :members

  validates :name, :presence => {:message => "Ryhmän nimi puuttuu"}
  validates :fee, :presence => {:message => "Hinta puuttuu"}
end