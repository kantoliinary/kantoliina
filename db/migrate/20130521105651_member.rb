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
      t.boolean     :membership, :default => true
      t.date        :expirationdate
      t.timestamps
    end
  end
end
