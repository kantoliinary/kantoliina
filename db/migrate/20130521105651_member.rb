class Member < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string   :surname
      t.string   :municipality
      t.string   :address
      t.string   :zipcode
      t.string   :postoffice
      t.string   :email
      t.string   :membergroup
      t.integer  :membernumber
      t.date     :payday
      t.timestamps
    end
  end
end
