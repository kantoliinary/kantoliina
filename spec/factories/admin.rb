FactoryGirl.define do
  factory :admin do |f|
    f.username "admin"
    f.password "qwerty123"
    f.email "testi@testi.fi"
  end
end

FactoryGirl.define do
  factory :invalid_admin, parent: :admin do |f|
    f.password "qw"
  end
end