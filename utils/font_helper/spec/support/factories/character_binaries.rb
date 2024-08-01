# frozen_string_literal: true

FactoryBot.define do
  factory :character_binary, class: Array do
    initialize_with do
      [
        first_byte_1, first_byte_2, bytes, width
      ].flatten
    end

    transient do
      first_byte_1 { start_position / 256 }
      first_byte_2 { start_position % 256 }
      bytes  { Random.rand(max_bytes) + 1 }
      width { 24 }
      start_position { 0 }

      height { 28 }
      byte_height { (height / 8.0).ceil }
      max_bytes { byte_height * width }
    end
  end
end
