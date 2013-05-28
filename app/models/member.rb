#encoding: utf-8
##
# None of fields cannot be blank.
# Email must be in email format.
# Membernumber can have only integers and its length must be 3-19.

class Member < ActiveRecord::Base
  attr_accessible :name, :surname, :municipality, :address, :zipcode, :postoffice, :email, :membergroup, :membernumber, :membership, :expirationdate
  validates :name, :presence => {:message => "Etunimi puuttuu!"}
  validates :surname, :presence => {:message => "Sukunimi puuttuu!"}
  validates :municipality, :presence => {:message => "Kunta puuttuu!"}
  validates :address, :presence => {:message => "Osoite puuttuu!"}
  validates :zipcode, :presence => {:message => "Postinumero puuttuu!"}
  validates :postoffice, :presence => {:message => "Postitoimipaikka puuttuu!"}
  validates :email, :presence => {:message => "Sähköpostiosoite puuttuu!"},
            :format => {
                :with    => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                :message => "Sähköpostiosoitteen muoto on väärä!"}
  validates :membergroup, :presence => true
<<<<<<< HEAD
  validates :membernumber, :presence => {:message => "Jäsennumero puuttuu!"}, :numericality => {:only_integer => true, :message => "Jäsennumerossa tulee olla vain numeroita!"}, :length => {:minimum => 3,  :maximum => 19, :message => "Jasennumeron tulee olla 3-19 merkkia pitka!"}
  validates :expirationdate, :presence => {:message => "Jäsenyyden päättymispäivä puuttuu!"}
=======
  validates :membernumber, :presence => {:message => "Jäsennumero puuttuu!"}, :numericality => {:only_integer => true, :message => "Jäsennumerossa tulee olla vain numeroita!"}, :length => {:minimum => 3,  :maximum => 19, :message => "Jäsennumeron tulee olla 3-19 merkkiä pitkä!"}
  validates :expirationdate, :presence => {:message => "Viimeinen maksupäivä puuttuu!"}
>>>>>>> a44d08f78aeafc2440573e5a5292d5401013744e

  @@all_search_fields = {:municipality => "Asuinkunta", :name => "Etunimi"}

  def self.all_search_fields
    @@all_search_fields
    #%w(Asuinkunta, Maksustatus Jäsenstatus)
  end

  def self.has_field? field
    @@all_search_fields.has_key?(field.to_sym)
  end

end