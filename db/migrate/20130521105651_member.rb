class Member < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string      :firstnames
      t.string      :surname
      t.string      :municipality
      t.string      :address
      t.string      :zipcode
      t.string      :postoffice
      t.string      :country
      t.string      :email
      t.string     :membernumber
      t.references  :membergroup
      t.string     :membershipyear
      t.boolean     :paymentstatus
      t.date        :invoicedate
      t.boolean     :active, :default => true
      t.boolean     :lender, :default => false
      t.boolean     :support, :default => false
      t.timestamps
    end
  end
end
