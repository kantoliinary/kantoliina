#encoding: utf-8
##
# Login must be 3-20 symbol and password must be 8-20 symbol.

class Admin < ActiveRecord::Base
  attr_accessible :login, :password, :password_digest
  has_secure_password
  validates :password, :login, :presence => true
  validates :login, :length => {
    :minimum => 3,
    :maximum => 20,
    :too_short => "Käyttäjätunnuksen tulee olla vähintaan 3 merkkiä",
    :too_long => "Kayttajatunnuksen tulee olla korkeintaan 20 merkin pituinen"
  }
  validates :password, :length => {
      :minimum => 8,
      :maximum => 20,
      :too_short => "Salasanan tulee olla vahintaan 8 merkkia",
      :too_long => "Salasanan tulee olla korkeintaan 20 merkkia"
  }
end
