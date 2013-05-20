class Admin < ActiveRecord::Base
  attr_accessible :login, :password
end
