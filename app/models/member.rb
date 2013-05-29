#encoding: utf-8
##
# None of the fields can be blank.
# E-mail must be in e-mail format.
# Member number can have only integers and its length must be 3-19 symbols.

class Member < ActiveRecord::Base
  attr_accessible :firstnames, :surname, :municipality, :address, :zipcode, :postoffice, :email, :membergroup_id, :membernumber, :membership, :expirationdate
  belongs_to :membergroup
  validates :firstnames, :presence => {:message => "Etunimi puuttuu!"}
  validates :surname, :presence => {:message => "Sukunimi puuttuu!"}
  validates :municipality, :presence => {:message => "Kunta puuttuu!"}
  validates :address, :presence => {:message => "Osoite puuttuu!"}
  validates :zipcode, :presence => {:message => "Postinumero puuttuu!"}
  validates :postoffice, :presence => {:message => "Postitoimipaikka puuttuu!"}
  validates :email, :presence => {:message => "Sähköpostiosoite puuttuu!"},
            :format => {
                :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                :message => "Sähköpostiosoitteen muoto on väärä!"}

  #validates :membergroup, :presence => true
  validates :membernumber, :presence => {:message => "Jäsennumero puuttuu!"}, :numericality => {:only_integer => true, :message => "Jäsennumerossa tulee olla vain numeroita!"}, :length => {:is => 5, :message => "Jäsennumeron tulee olla tasan 5 merkkiä pitkä!"}
  validates :expirationdate, :presence => {:message => "Jäsenyyden päättymispäivä puuttuu!"}

  @@all_search_fields = {:firstnames => "Etunimi", :surname => "Sukunimi", :municipality => "Asuinkunta", :address => "Osoite", :zipcode => "Postinumero", :postoffice => "Postitoimipaikka", :email => "Sähköposti", :membergroup => "Jäsenryhmä", :membernumber => "Jäsennumero"}
  #@@ref_number = self.generate_refnumber


  def self.all_search_fields
    @@all_search_fields
    #%w(Asuinkunta, Maksustatus Jäsenstatus)
  end

  def self.has_field? field
    @@all_search_fields.has_key?(field.to_sym)
  end


  def self.generate_refnumber membernumber

    input = membernumber.to_s.reverse!
    base = "731" * 50

    index = 0
    sum = 0

    input.each_byte do |b|
      result = b.chr.to_i * base[index % 3].chr.to_i
      sum = sum + result
      index = index + 1

    end
    difference = (10 - (sum % 10)) % 10

    input = "#{difference}#{input}".reverse
    return input


  end


end

