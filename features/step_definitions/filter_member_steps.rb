
#When /^(?:|I )click a menu "([^"]*)"$/ do |selector|
#  find(selector).click

When /^I click on "([^\"]+)"$/ do |text|
  matcher = ['*', { :text => text }]
  element = page.find(:css, *matcher)
  while better_match = element.first(:css, *matcher)
    element = better_match
  end
  element.click
end