Given /the following partners exist/ do |partners_table|
  partners_table.hashes.each do |partner|
    Partner.create!(partner)
  end
end