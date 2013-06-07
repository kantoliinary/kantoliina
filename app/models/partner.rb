#encoding: utf-8

##
# The model for an partner in the database.
# Validates the presence and length of the username and password.

class Partner < ActiveRecord::Base
  attr_accessible :username, :password, :password_confirmation, :password_digest

  validates :username, :presence => {:message => "Käyttäjätunnus puuttuu"}
  validates :password, :presence => {:message => "Salasana puuttuu"}
  validate :validate_username
  validates :password, :length => {
      :minimum => 8,
      :maximum => 20,
      :too_short => "Salasanan tulee olla vähintään 8 merkin pituinen",
      :too_long => "Salasanan tulee olla korkeintaan 20 merkin pituinen"
  }, :confirmation => {:message => "Salasanan vahvistus on virheellinen"}
  has_secure_password


  ##
  # Validates the username submitted by the admin and shows error messages if the username is not valid
  def validate_username
    if username.nil?
      errors.add(:username, "Käyttäjätunnuksen tulee olla vähintään 3 merkin pituinen")
      return false
    end

    if username.length < 3
      errors.add(:username, "Käyttäjätunnuksen tulee olla vähintään 3 merkin pituinen")
      return false
    end
    if username.length > 20
      errors.add(:username, "Käyttäjätunnuksen tulee olla korkeintaan 20 merkin pituinen")
      return false
    end
    true
  end
end
