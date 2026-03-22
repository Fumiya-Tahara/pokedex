FactoryBot.define do
  factory :pokemon_type do
    association :pokemon
    association :type
    slot { 1 }
  end
end
