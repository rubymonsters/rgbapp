FactoryGirl.define do
  factory :event do
    name "Rails Girls Event"
    place "Venue"
    scheduled_at Time.now
    application_start Time.now
    application_end Time.now
    confirmation_date Time.now
  end

  factory :user do
    email "user@email.com"
    password "123456"
    admin false
  end

  factory :application do
    association :event
    name "Rails Applicant"
    sequence(:email) { |n| "person#{n}@example.com" }
    level "0"
    os "Linux"
    language_en true
    language_de false
    random_id { SecureRandom.hex(12) }
  end
end
