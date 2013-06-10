class Membergroup < ActiveRecord::Migration
  def change
    create_table :membergroups do |t|
      t.string :name
      t.float  :fee
      t.boolean :onetimefee
    end
  end

end
