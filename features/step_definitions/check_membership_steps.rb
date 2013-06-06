Given /the following members exist/ do |members_table|
  members_table.hashes.each do |member|
    Member.create!(member)
  end
end
