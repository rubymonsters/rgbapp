FactoryBot.define do
  factory :coach_application do

  end
  factory :coach do
    association :user
    name { "Swenja" }
    gender { "female" }
    language_de { true }
    language_en { true }
    notifications { true }
  end

  factory :event do
    name { "Code Curious Event" }
    place { "Venue" }
    application_start { Time.now }
    application_end { Time.now }
    confirmation_date { Time.now }
    coach_the_coaches_date { Time.now }
    coach_the_coaches_start_time { Time.now }
    coach_the_coaches_end_time { Time.now }
    installation_get_together_date { Time.now }
    installation_get_together_start_time { Time.now }
    installation_get_together_end_time { Time.now }
    scheduled_at { Time.now }
    start_time { "10:00" }
    end_time { "18:00" }
  end

  factory :user do
    email { "user@email.com" }
    password { "123456" }
    admin { false }
  end

  factory :application do
    association :event
    name { "Curious Applicant" }
    sequence(:email) { |n| "person#{n}@example.com" }
    sequence(:sequence_number)
    level { "0" }
    os { "Linux" }
    language_en { true }
    language_de { false }
    random_id { SecureRandom.hex(12) }
  end
end
