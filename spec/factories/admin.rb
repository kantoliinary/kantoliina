FactoryGirl.define do
  factory :admin do |f|
    f.login "admin"
    f.password "qwerty123"
  end
end