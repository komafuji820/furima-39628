FactoryBot.define do
  factory :purchase_address do
    post_code         {"123-4567"}
    prefecture_id     {Faker::Number.between(from: 2, to: 48)}
    municipalities    {Faker::Address.city}
    house_number      {Faker::Address.street_address}
    house_name        {Faker::Lorem.word}
    phone_number      {Faker::Number.number(digits: 10)}
    token             {Faker::Internet.device_token}
  end
end