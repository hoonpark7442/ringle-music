FactoryBot.define do
  factory :group_membership do
    trait :admin do
      type_of_user { "admin" }
    end

    trait :member do
      type_of_user { "member" }
    end

    association :user, :group
  end
end
