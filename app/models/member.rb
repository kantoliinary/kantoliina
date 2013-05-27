class Member < ActiveRecord::Base
  attr_accessible :name, :surname, :municipality, :address, :zipcode, :postoffice, :email, :membergroup, :membernumber, :membership, :payday
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
  validates :zipcode, :presence => {:message => "Postinumero puuttuu!"}, :length => {:minimum => 5,  :maximum => 5, :message => "Postinumeron tulee olla viiden merkin pituinen!"}, :numericality => {:only_integer => true, :message => "Postinumeron tulee sisaltaa vain numeroita!"}
  validates :postoffice, :presence => {:message => "Postitoimipaikka puuttuu!"}
  validates :email, :presence => {:message => "Sahkopostiosoite puuttuu!"},
            :format => {
                :with    => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                :message => "Sahkopostiosoitteen muoto on vaara!"}
  validates :membergroup, :presence => true
  validates :membernumber, :presence => {:message => "Jasennumero puuttuu!"}, :numericality => {:only_integer => true, :message => "Jasennumerossa tulee olla vain numeroita!"}, :length => {:minimum => 3,  :maximum => 19, :message => "Jasennumeron tulee olla 3-19 merkkia pitka!"}
  validates :payday, :presence => {:message => "Viimeinen maksupaiva puuttuu!"}
end