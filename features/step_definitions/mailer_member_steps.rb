#encoding:UTF-8
When /^I upload an exact file$/ do
  attach_file :attachment, (File.join(Rails.root, 'features', 'support', 'env.rb'))
end

Given /^a confirmation box saying "([^"]*)" should pop up$/ do |message|
  @expected_message = message
end
Given /^I expect to click "([^"]*)" on an alert box/ do |option|
  retval = (option == "OK") ? "true" : "false"

  page.evaluate_script("window.alert = function (msg) {

return #{retval};
}")

end
