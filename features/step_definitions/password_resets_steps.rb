Given /^(?:a clear email queue|no emails have been sent)$/ do
  reset_mailer
end

# Use this step to open the most recently sent e-mail.
When /^I open the email$/ do
  open_email(current_email_address)
end

When /^I follow "(.*)" in the email$/ do |link|
  visit_in_email(link)
end

Then /^I should receive (.*) emails?$/ do |amount|
  amount = 1 if amount == "an"
  unread_emails_for(current_email_address).size.should == amount
end

Then /^"([^']*?)" should receive (\d+) emails?$/ do |address, n|
  unread_emails_for(address).size.should == n.to_i
end

Then /^"([^']*?)" should have (\d+) emails?$/ do |address, n|
  mailbox_for(address).size.should == n.to_i
end

Then /^"([^']*?)" should not receive an email$/ do |address|
  find_email(address).should be_nil
end

Then /^I should see "(.*)" in the subject$/ do |text|
  current_email.subject.should =~ Regexp.new(text)
end

Then /^I should see "(.*)" in the email$/ do |text|
  current_email.body.should =~ Regexp.new(text)
end

When %r{^"([^']*?)" opens? the email with subject "([^']*?)"$} do |address, subject|
  open_email(address, :with_subject => subject)
end

When %r{^"([^']*?)" opens? the email with text "([^']*?)"$} do |address, text|
  open_email(address, :with_text => text)
end