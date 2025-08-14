FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password123" }
    password_confirmation { "password123" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    trait :admin do
      admin { true }
    end

    trait :oauth_user do
      provider { "google_oauth2" }
      uid { Faker::Number.number(digits: 10).to_s }
    end

    trait :github_user do
      provider { "github" }
      uid { Faker::Number.number(digits: 8).to_s }
    end
  end
end