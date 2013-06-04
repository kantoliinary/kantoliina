FactoryGirl.define do
  factory :partner do |f|
    f.username "partner"
    f.password "qwerty123"
  end
end

FactoryGirl.define do
  factory :invalid_partner, parent: :partner do |f|
    f.username "partner"
    f.password "qw"
  end
end
