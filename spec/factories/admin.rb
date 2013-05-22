FactoryGirl.define do
  factory :admin do |f|
    f.login "admin"
    f.password "123"
  end
end