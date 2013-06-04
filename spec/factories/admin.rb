FactoryGirl.define do
  factory :admin do |f|
    f.username "admin"
    f.password "qwerty123"
    f.email "dsafsafa@dqxxaa.zz"
  end
end

FactoryGirl.define do
  factory :invalid_admin, parent: :admin do |f|
    f.username "admin"
    f.password "qw"
  end
end