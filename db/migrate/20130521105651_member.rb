class Member < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string      :firstnames
      t.string      :surname
      t.string      :municipality
      t.string      :address
      t.string      :zipcode
      t.string      :postoffice
      t.string      :email
      t.integer     :membernumber
      t.references  :membergroup
      t.integer     :membershipyear
      t.boolean     :paymentstatus
      t.date        :invoicedate
      t.boolean     :deleted, :default => false
      t.boolean     :lender, :default => false
      t.boolean     :support, :default => false

      t.timestamps
    end
  end
end
