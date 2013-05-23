FactoryGirl.define do
  factory :admin do |f|
    f.login "admin"
    f.password "qwerty123"
  end
end

FactoryGirl.define do
  factory :invalid_admin, parent: :admin do |f|
    f.login "admin"
    f.password "qw"
  end
end