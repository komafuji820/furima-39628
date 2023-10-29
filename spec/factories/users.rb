FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end

    nickname              {Faker::Name.initials}
    email                 {Faker::Internet.email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    last_name             {person.last.kanji}
    first_name            {person.first.kanji}
    ruby_last_name        {person.last.katakana}
    ruby_first_name       {person.first.katakana}
    birthday              {Faker::Date.birthday(min_age: 5, max_age: 93)}

  end
end
