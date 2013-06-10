#encoding: UTF-8

##
# The model for a membergroup in the database. Represents the official status a member has in the association.
#
class Membergroup < ActiveRecord::Base
  attr_accessible :name, :fee, :onetimefee
end