class Admin < ActiveRecord::Base
  attr_accessible :login, :password, :password_digest
  has_secure_password
  validates :password, :presence => {:on => :create}
end
