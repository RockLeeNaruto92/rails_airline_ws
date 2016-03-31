FactoryGirl.define do
  factory :flight do
    code {Faker::Code.isbn}
    start_time {Faker::Time.between 4.days.ago, 2.days.ago, :morning}
    end_time {Faker::Time.between 2.days.ago, Time.now, :night}
    start_point {Faker::Address.city}
    end_point {Faker::Address.city}
    seats {Faker::Number.number 2}
    cost {Faker::Number.number 3}
    airline {Airline.all.sample}
  end
end
