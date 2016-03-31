FactoryGirl.define do
  factory :airline do
    code {Faker::Code.isbn}
    name {Faker::Company.name}
    website {Faker::Internet.url}
  end
end
