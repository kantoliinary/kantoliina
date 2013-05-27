When /^I select "([^"]*)" as the (.+) "([^"]*)" date$/ do |date, model, selector|
  date = Date.parse(date)
  select(date.year.to_s, :from => "#{model}[#{selector}(1i)]")
  select(date.strftime("%B"), :from => "#{model}[#{selector}(2i)]")
  select(date.day.to_s, :from => "#{model}[#{selector}(3i)]")
end