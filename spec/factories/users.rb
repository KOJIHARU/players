FactoryGirl.define do
  factory :user do
    trait :inactive do
      status :inactive
    end
    trait :registered do
      status :registered
    end

    factory :email_user, class: EmailUser do
      sequence(:email) { |n| "email#{n}@example.com" }
      password { 'password' }
      type 'EmailUser'
    end
  end
end
