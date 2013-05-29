#encoding: utf-8
##
# Login must be 3-20 symbols long and password must be 8-20 symbols long.

class Admin < ActiveRecord::Base
  attr_accessible :login, :password, :password_digest
  has_secure_password
  validates :password, :login, :presence => true
  validates :login, :length => {
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
