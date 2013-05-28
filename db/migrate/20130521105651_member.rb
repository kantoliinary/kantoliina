class Member < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :firstnames
      t.string   :surname
      t.string   :municipality
      t.string   :address
      t.string   :zipcode
      t.string   :postoffice
      t.string   :email
      t.string   :membergroup
      t.integer  :membernumber
      t.boolean  :membership, :default => true
      t.date     :expirationdate
      t.timestamps
    end
  end
end
