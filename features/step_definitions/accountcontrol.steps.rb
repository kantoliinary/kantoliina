When /^I fill inside "(.*)" the following:$/ do |id,table|
  within("##{id}") do
    table.rows_hash.each do |name, value|
      step %{I fill in "#{name}" with "#{value}"}
    end
  end
end

When /^I press the button "(.*)" inside "(.*)"$/ do |button, id |
  within("##{id}") do
    click_button(button)
  end
end