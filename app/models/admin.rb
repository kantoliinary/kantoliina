class Admin < ActiveRecord::Base
  attr_accessible :login, :password, :password_digest
  has_secure_password
  validates :password, :login, :presence => true
  validates :login, :length => {
    :minimum => 3,
    :maximum => 20,
    :too_short => "Kayttajatunnuksen tulee olla vahintaan 3 merkkia",
    :too_long => "Kayttajatunnus tulee olla korkeintaan 20 merkkia"
  }
  validates :password, :length => {
      :minimum => 8,
      :maximum => 20,
      :too_short => "Salasanan tulee olla vahintaan 8 merkkia",
      :too_long => "Salasanan tulee olla korkeintaan 20 merkkia"
  }
end
