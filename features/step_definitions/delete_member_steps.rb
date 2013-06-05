Given /^I expect to click "([^"]*)" on a confirmation box/ do |option|
  retval = (option == "OK") ? "true" : "false"

  page.evaluate_script("window.confirm = function (msg) {

return #{retval};
}")

end
