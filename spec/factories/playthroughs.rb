# frozen_string_literal: true

FactoryBot.define do
  factory :playthrough do
    player
    timestamp { Date.yesterday }
    score { 100 }
    time_spent { 60 }
  end
end
