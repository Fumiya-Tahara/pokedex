FactoryBot.define do
  factory :pokemon do
    sequence(:national_number) { |n| n }
    sequence(:name) { |n| "ポケモン#{n}" }
    height { 0.7 }
    weight { 6.9 }
  end
end
