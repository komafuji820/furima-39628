FactoryBot.define do
  factory :item do

    name           {Faker::Lorem.word}
    explain        {Faker::Lorem.word}
    price          {Faker::Number.between(from: 300, to: 9999999)}
    category_id    {Faker::Number.between(from: 2, to: 11)}
    condition_id   {Faker::Number.between(from: 2, to: 7)}
    cost_id        {Faker::Number.between(from: 2, to: 3)}
    prefecture_id  {Faker::Number.between(from: 2, to: 48)}
    span_id        {Faker::Number.between(from: 2, to: 4)}

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test.jpg'), filename: 'test.jpg')
    end
    
  end
end
