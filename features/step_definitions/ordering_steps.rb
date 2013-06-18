Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
     puts page.body.index(/#{e1}/)
     puts page.body.index(/#{e2}/)
  fail("fail!") if page.body.index(/#{e1}/) > page.body.index(/#{e2}/)
end

Then /^row (\d+) column (\d+) of table "([^"]*)" should be "([^"]*)"$/ do |row,column,table_id,value|
  locator = "css=table##{table_id} tbody tr:nth-of-type(#{row}) td:nth-of-type(#{column})"

  selenium.get_text(locator).should == value
end

Then /^table "([^"]*)" should have the values:$/ do |table_id, table|
  table.hashes.each do |row|
    Then %{row #{row[:row]} column #{row[:col]} of table "#{table_id}" should be "#{row[:value]}"}
  end
end