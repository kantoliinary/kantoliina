Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  fail("fail!") if page.body.index(/#{e1}/) > page.body.index(/#{e2}/)
end