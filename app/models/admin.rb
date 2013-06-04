#encoding: utf-8

##
# The model for an admin in the database.
# Validates the presence and length of the username and password.

class Admin < ActiveRecord::Base
  attr_accessible :username, :password, :password_digest, :email
  has_secure_password
  validates :password, :username, :presence => true
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
  validates :email, :presence => {:message => "Sähköpostiosoite puuttuu!"},
            :format => {
                :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                :message => "Sähköpostiosoitteen muoto on väärä!"}
  def generate_and_send_new_password
    new_password = ""
    chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!#,.;:?%&".split(//)
    (0..8).each do |i|
      new_password += chars.at(rand(chars.length))
    end
    puts new_password
    self.update_attributes(:password => new_password)
    save!
    AdminMailer.password_reset(self, new_password).deliver
    new_password
  end
end
