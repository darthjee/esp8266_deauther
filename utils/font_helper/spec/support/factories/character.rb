# frozen_string_literal: true

FactoryBot.define do
  factory :character, class: FontHelper::Character do
    initialize_with do
      FontHelper::Character.new(code)
    end

    transient do
      code { 48 }
    end
  end
end
