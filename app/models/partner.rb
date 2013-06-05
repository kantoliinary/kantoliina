#encoding: utf-8

##
# The model for an partner in the database.
# Validates the presence and length of the username and password.

class Partner < ActiveRecord::Base
  attr_accessible :username, :password, :password_digest
  has_secure_password
  validates :username, :presence => {:message => "Käyttäjätunnus puuttuu"}
  validates :password, :presence => {:message => "Salasana puuttuu"}
  validates :username, :length => {
      :minimum => 3,
      :maximum => 20,
      :too_short => "Käyttäjätunnuksen tulee olla vähintään 3 merkin pituinen",
      :too_long => "Käyttäjätunnuksen tulee olla korkeintaan 20 merkin pituinen"
  }
  validates :password, :length => {
      :minimum => 8,
      :maximum => 20,
      :too_short => "Salasanan tulee olla vähintään 8 merkin pituinen",
      :too_long => "Salasanan tulee olla korkeintaan 20 merkin pituinen"
  }
end
