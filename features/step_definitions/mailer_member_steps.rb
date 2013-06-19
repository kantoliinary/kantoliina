When /^I upload a file with valid data for 3 new products$/ do
  attach_file(:csv_file, File.join('features', 'upload-files', 'products_csv_ok.csv'))
  click_button "Send file"
end

When /^I upload an exact file$/ do
  attach_file(:attachment, File.join('features', 'support', 'env.rb'))
  click_button "send_mailer"
end