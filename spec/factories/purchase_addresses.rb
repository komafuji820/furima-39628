FactoryBot.define do
  factory :purchase_address do
    post_code         {Faker::Number.leading_zero_number(digits: 3) + '-' + Faker::Number.leading_zero_number(digits: 4)}
    prefecture_id     {Faker::Number.between(from: 2, to: 48)}
    municipalities    {Faker::Address.city}
    house_number      {Faker::Address.street_address}
    house_name        {Faker::Lorem.word}
    phone_number      {Faker::Number.number(digits: 11)}
    token             {Faker::Internet.device_token}
  end
end