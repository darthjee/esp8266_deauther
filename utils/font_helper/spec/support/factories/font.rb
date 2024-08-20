# frozen_string_literal: true

FactoryBot.define do
  factory :font, class: FontHelper::Font do
    initialize_with do
      FontHelper::Font.new(width:, height:, characters:)
    end

    transient do
      width { 24 }
      height { 24 }

      characters do
        codes.map do |code|
          build(:character, code:, width:, height:)
        end
      end

      first_character { 48 }
      characters_count { 10 }

      codes do
        10.times.map do |index|
          first_character + index
        end
      end
    end
  end
end
