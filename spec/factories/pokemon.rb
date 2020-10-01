# frozen_string_literal: true

FactoryBot.define do
  factory :pokemon do
    sequence(:name) { |n| "Pikachu #{n}" }
    type_1 { 'Electric' }
    total { 10 }
    hp { 10 }
    attack { 10 }
    defense { 10 }
    sp_atk { 10 }
    sp_def { 10 }
    speed { 10 }
    generation { 10 }
    legendary { true }
  end
end
