class Member < ActiveRecord::Base
  attr_accessible :name, :surname, :municipality, :address, :zipcode, :postoffice, :email, :membergroup, :membernumber, :payday
  validates :name, :presence => {:message => "Etunimi puuttuu!"}
            #:format => {
            #    :with    => /\A[a-zA-Z]+\z/,
            #    :message => "Etunimen muoto ei kelpaa!"}
  validates :surname, :presence => {:message => "Sukunimi puuttuu!"}
            #:format => {
            #    :with    => /\A[a-zA-Z]+\z/,
            #    :message => "Sukunimen muoto ei kelpaa!"}
  validates :municipality, :presence => {:message => "Kunta puuttuu!"}
  validates :address, :presence => {:message => "Osoite puuttuu!"}
  validates :zipcode, :length => {:minimum => 5,  :maximum => 5, :message => "Postinumeron tulee olla viiden merkin pituinen!"}, :numericality => {:only_integer => {:message => "Postinumeron tulee sisaltaa vain numeroita!"}}, :presence => {:message => "Postinumero puuttuu!"}
  validates :postoffice, :presence => {:message => "Postitoimipaikka puuttuu!"}
  validates :email, :presence => {:message => "Sahkopostiosoite puuttuu!"},
            :format => {
                :with    => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                :message => "Sahkopostiosoitteen muoto on vaara!"}
  validates :membergroup, :presence => true
  validates :membernumber, :numericality => {:only_integer => {:message => "Jasennumerossa tulee olla vain numeroita!"}}, :length => {:minimum => 3,  :maximum => 19, :message => "Jasennumeron tulee olla 3-19 merkkia pitka!"}, :presence => {:message => "Jasennumero puuttuu!"}
  validates :payday, :presence => {:message => "Viimeinen maksupaiva puuttuu!"}
end