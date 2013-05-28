class Membergroup < ActiveRecord::Migration
  def change
    create_table :membergroups do |t|
      t.string :groupname
      t.float  :fee
    end
  end

end
