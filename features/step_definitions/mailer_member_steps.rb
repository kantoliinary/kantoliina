When /^I upload an exact file$/ do
  attach_file :attachment, (File.join(Rails.root, 'features', 'support', 'env.rb'))
end