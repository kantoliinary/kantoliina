When /I sign in/ do
  within("#session") do
    fill_in 'Username', :with => 'user@example.com'
    fill_in 'Password', :with => 'password'
  end
  click_link 'Sign in'
end