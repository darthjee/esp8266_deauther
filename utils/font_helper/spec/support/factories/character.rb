# frozen_string_literal: true

FactoryBot.define do
  factory :character, class: FontHelper::Character do
    initialize_with do
      FontHelper::Character.new(
        code:, width:, binary:
      )
    end

    transient do
      code { 48 }
      width { 32 }
      binary { [255] }
    end
  end
end
