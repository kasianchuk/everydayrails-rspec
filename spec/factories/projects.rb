FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "Project #{n}" }
    description     { 'A test project.' }
    due_on          { 1.week.from_now }
    association :owner

    factory :project_due_yesterday do
      due_on { 1.day.ago }
    end

    factory :project_due_today do
      due_on { Date.today }
    end

    trait :due_tommorow do
      due_on { 1.day.from_now }
    end

    trait :with_notes do
      after(:create) { |i| create_list(:note, 5, project: i) }
    end

    trait :invalid do
      name { nil }
    end
  end
end
