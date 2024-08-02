# frozen_string_literal: true

FactoryBot.define do
  factory :binary, class: Array do
    initialize_with do
      size.times.map { Random.rand(256) }
    end

    transient do
      size { Random.rand(10) }
    end
  end
end
