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
  validates :email, :presence => {:message => "Sähkopostiosoite puuttuu!"},
            :format => {
                :with    => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                :message => "Sähköpostiosoitteen muoto on väärä!"}
  validates :membergroup, :presence => true
  validates :membernumber, :presence => {:message => "Jäsennumero puuttuu!"}, :numericality => {:only_integer => true, :message => "Jäsennumerossa tulee olla vain numeroita!"}, :length => {:minimum => 3,  :maximum => 19, :message => "Jasennumeron tulee olla 3-19 merkkia pitka!"}
  validates :expirationdate, :presence => {:message => "Viimeinen maksupäivä puuttuu!"}

  def self.all_sort_fields
    %w(Asuinkunta Maksustatus Jäsenstatus)
  end
end