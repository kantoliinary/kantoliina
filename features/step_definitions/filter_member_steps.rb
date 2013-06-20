When /^(?:|I )click a text "([^"]*)"$/ do |selector|

  page.all(selector).click
end

When /^I click on "([^\"]+)"$/ do |text|
  matcher = ['*', {:text => text}]
  element = page.find(:css, *matcher)
  while better_match = element.first(:css, *matcher)
    element = better_match
  end
  element.click
end