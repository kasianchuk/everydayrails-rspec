FactoryBot.define do
  factory :user, aliases: [:owner] do
    first_name       { 'Pavlo' }
    last_name        { 'Kasianchuk' }
    sequence(:email) { |n| "test#{n}@mail.com" }
    password         { 'password123' }
  end
end
