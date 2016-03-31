FactoryGirl.define do
  factory :constract do
    flight {Flight.all.sample}
    customer_id_number {Faker::Code.ean}
    company_name {Faker::Name.name}
    company_phone {Faker::PhoneNumber.phone_number}
    company_address {Faker::Address.street_address}

    before(:create) do |constract|
      constract.booking_seats = Random.rand constract.flight.available_seats
    end
  end
end
