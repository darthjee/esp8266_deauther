# frozen_string_literal: true

FactoryBot.define do
  factory :font_binary, class: Array do
    initialize_with do
      [
        width, height, first_character, characters_count,
        characters_table,
        characters_binaries
      ].flatten
    end

    transient do
      width { 24 }
      height { 32 }
      first_character { 48 }
      characters_count { 10 }
      
      character_bytes { 4 }
      character_width { 24 }

      characters_table do
        characters_count.times.map do |index|
          start_position  = index * character_bytes
          [start_position / 256, start_position  % 256, character_bytes, character_width ]
        end
      end

      characters_binaries do
        (characters_count * character_bytes).times.map { 100 }
      end
    end
  end
end
