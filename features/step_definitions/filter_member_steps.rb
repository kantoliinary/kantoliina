When /^(?:|I )click a menu "([^"]*)"$/ do |selector|
  find(selector).click
end