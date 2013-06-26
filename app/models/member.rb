#encoding: utf-8
##
# The model for a member in the database.
# Validates the presence and form of the text written by the admin in the text fields.
#

class Member < ActiveRecord::Base
  attr_accessible :firstnames, :surname, :municipality, :address, :zipcode, :postoffice, :country, :email, :membergroup_id, :membernumber, :active, :membershipyear, :paymentstatus, :invoicedate, :reminderdate, :lender, :support, :info
  belongs_to :membergroup
  #validates :firstnames, :presence => {:message => "Etunimi puuttuu"}
  validates :surname, :presence => {:message => "Sukunimi puuttuu"}
  validates :municipality, :presence => {:message => "Kunta puuttuu"}
  validates :address, :presence => {:message => "Osoite puuttuu"}
  validates :zipcode, :presence => {:message => "Postinumero puuttuu"}
  validates :postoffice, :presence => {:message => "Postitoimipaikka puuttuu"}
  validates :country, :presence => {:message => "Maa puuttuu"}
  validates :email, :presence => {:message => "Sähköpostiosoite puuttuu"},
            :format => {
                :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                :message => "Sähköpostiosoitteen muoto on väärä"}

  validates :membergroup_id, :numericality => {:only_integer => true, :message => "Valitse jäsenryhmä"}
  validates :membernumber, :uniqueness => {:message => "Jäsennumero on jo käytössä"}, :presence => {:message => "Jäsennumero puuttuu"}, :numericality => {:only_integer => true, :message => "Jäsennumerossa tulee olla vain numeroita"}, :length => {:is => 5, :message => "Jäsennumeron tulee olla tasan 5 merkkiä pitkä"}
  validates :membershipyear, :numericality => {:only_integer => true}, :length => {:is => 4}
  validates :paymentstatus, :inclusion => {:in => [true, false]}
  validates :lender, :inclusion => {:in => [true, false]}
  validates :support, :inclusion => {:in => [true, false]}

  @@refernumberprefix = '6004'

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

  def as_json(options={})
    {:id => self.id,
     :membernumber => self.membernumber,
     :name => "#{self.surname} #{self.firstnames}",
     :email => self.email,
     :municipality => self.municipality,
     :address => self.address,
     :zipcode => self.zipcode,
     :postoffice => self.postoffice,
     :country => self.country,
     :membergroup => self.membergroup.name,
     :membershipyear => self.membershipyear,
     :paymentstatus => self.paymentstatus,
     :active => self.active,
     :support => self.support,
     :lender => self.lender,
     :invoicedate => (self.invoicedate ? self.invoicedate.strftime("%d.%m.%Y") : ""),
     :reminderdate => (self.reminderdate ? self.reminderdate.strftime("%d.%m.%Y") : "")
    }
  end
  def self.as_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |item|
        csv << item.attributes.values_at(*column_names)
      end
    end
  end
end

