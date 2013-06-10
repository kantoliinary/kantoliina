#encoding: utf-8
##
# The model for a member in the database.
# Validates the presence and form of the text written by the admin in the text fields.
#

class Member < ActiveRecord::Base
  attr_accessible :firstnames, :surname, :municipality, :address, :zipcode, :postoffice, :email, :membergroup_id, :membernumber, :membership, :membershipyear, :paymentstatus, :invoicedate, :lender, :support
  belongs_to :membergroup
  validates :firstnames, :presence => {:message => "Etunimi puuttuu"}
  validates :surname, :presence => {:message => "Sukunimi puuttuu"}
  validates :municipality, :presence => {:message => "Kunta puuttuu"}
  validates :address, :presence => {:message => "Osoite puuttuu"}
  validates :zipcode, :presence => {:message => "Postinumero puuttuu"}
  validates :postoffice, :presence => {:message => "Postitoimipaikka puuttuu"}
  validates :email, :presence => {:message => "Sähköpostiosoite puuttuu"},
            :format => {
                :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                :message => "Sähköpostiosoitteen muoto on väärä"}

  validates :membergroup_id, :numericality => {:only_integer => true, :message => "Valitse jäsenryhmä"}
  validates :membernumber, :uniqueness => {:message => "Jäsennumero on jo käytössä"}, :presence => {:message => "Jäsennumero puuttuu"}, :numericality => {:only_integer => true, :message => "Jäsennumerossa tulee olla vain numeroita"}, :length => {:is => 5, :message => "Jäsennumeron tulee olla tasan 5 merkkiä pitkä"}
  validates :membershipyear, :numericality => {:only_integer => true}, :length => {:is => 4}
  validates :paymentstatus, :inclusion => {:in => [true, false]}
  validates :lender, :inclusion => {:in => [true, false]}
  validates :support,:inclusion => {:in => [true, false]}

  @@all_search_fields = {:firstnames => "Etunimi", :surname => "Sukunimi", :municipality => "Asuinkunta", :address => "Osoite", :zipcode => "Postinumero", :postoffice => "Postitoimipaikka", :email => "Sähköposti", :membernumber => "Jäsennumero"}
  @@refernumberprefix = '6004'
  ##
  #  Searches all search fields and returns them.
  def self.all_search_fields
    @@all_search_fields
    #%w(Asuinkunta, Maksustatus Jäsenstatus)
  end

  ##
  #  Ensures that the field exists.
  def self.has_field? field
    @@all_search_fields.has_key?(field.to_sym)
  end

  ##
  # Generates a reference number from a member number using a mathematical formula.
  def self.generate_refnumber membernumber

    input = (@@refernumberprefix + membernumber.to_s).reverse!
    base = "731"

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

