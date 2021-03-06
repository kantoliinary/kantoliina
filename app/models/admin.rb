#encoding: utf-8

##
# The model for an admin in the database.
# Validates the presence and length of the username and password.

class Admin < ActiveRecord::Base
  attr_accessible :username, :password, :password_confirmation, :password_digest, :email
  validates :username, :presence => {:message => "Käyttäjätunnus puuttuu"}
  validates :password, :presence => {:message => "Salasana puuttuu"}
  validate :validate_username, :validate_email
  validates :password, :length => {
      :minimum => 8,
      :maximum => 20,
      :too_short => "Salasanan tulee olla vähintään 8 merkin pituinen",
      :too_long => "Salasanan tulee olla korkeintaan 20 merkin pituinen"
  }, :confirmation => {:message => "Salasanan vahvistus on virheellinen"}
  has_secure_password

  ##
  # Generates and sends a new passwords to the admin e-mail
  def generate_and_send_new_password
    new_password = ""
    chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!#,.;:?%&".split(//)
    (0..8).each do |i|
      new_password += chars.at(rand(chars.length))
    end
    self.update_attributes(:password => new_password)
    save!
    AdminMailer.password_reset(self, new_password).deliver
    new_password
  end

  ##
  # Validates the username given by the admin and gives error messages when the password is not valid
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

  def validate_email
    if email.nil?
      errors.add(:email, "Sähköpostiosoite puuttuu")
      return false
    end
    if !email.match(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)
      errors.add(:email, "Sähköpostiosoitteen muoto on väärä")
      return false
    end
    true
  end
end
