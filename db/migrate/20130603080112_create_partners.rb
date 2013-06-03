class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string :username
      t.string :password_digest

      t.timestamps
    end
  end
end
