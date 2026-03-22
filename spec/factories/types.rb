FactoryBot.define do
  factory :type do
    sequence(:name) { |n| "タイプ#{n}" }
  end
end
