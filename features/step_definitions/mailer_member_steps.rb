#encoding:UTF-8
When /^I upload an exact file$/ do
  attach_file :attachment, (File.join(Rails.root, 'features', 'support', 'env.rb'))
end

Given /^a confirmation box saying "([^"]*)" should pop up$/ do |message|
  @expected_message = message
end

#Given /^I expect to click a button "([^"]*)" on an alert box saying "([^"]*)"$/ do |option, message|
#  retval = (option == "OK") ? "true" : "false"
#
#  page.evaluate_script("window.alert = function (msg) {
#    $.cookie('alert_message', msg, {path: '/'});
#    return #{retval};
#  }")
#
#  @expected_message = message
#end


#@selenium
#Then /^I should see the right message$/ do
#  selenium.get_alert.should eql("Antamasi sähköpostiosoite on virheellinen")
#end

Given /^I expect to click "([^"]*)" on an alert box/ do |option|
  retval = (option == "OK") ? "true" : "false"

  page.evaluate_script("window.alert = function (msg) {

return #{retval};
}")

end
