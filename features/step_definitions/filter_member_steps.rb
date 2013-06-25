When /^(?:|I )click a text "([^"]*)"$/ do |selector|

  find(selector).click
end

When /^I click on "([^\"]+)"$/ do |text|
  matcher = ['*', {:text => text}]
  element = page.find(:css, *matcher)
  while better_match = element.first(:css, *matcher)
    element = better_match
  end
  element.click
end

#Then /^I should see the image "(.+)"$/ do |imagename|
#  page.should have_selector("img[src$='#{imagename}']")
#end
#
#Then /^I should not see the image "(.+)"$/ do |imagename|
#  page.should_not have_selector("img[src$='#{imagename}']")
#end
