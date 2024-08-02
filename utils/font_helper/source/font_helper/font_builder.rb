# frozen_string_literal: true

class FontHelper
  class FontBuilder
    attr_reader :width, :height, :first_char, :char_count, :binaries

    class << self
      def build(*)
        new(*).build
      end
    end

    def initialize(width, height, first_char, char_count, *binaries)
      @width = width
      @height = height
      @first_char = first_char
      @char_count = char_count
      @binaries = binaries
    end

    def build
      font.tap do
        attach_characters
      end
    end

    private

    def attach_characters
      char_count.times.each do |index|
        code = index + first_char
        character_information = characters_informations[index * 4, 4]
        font << CharacterBuilder.build(height, code, character_information, *characters_binaries)
      end
    end

    def characters_informations
      @characters_informations ||= binaries[0, char_count * 4]
    end

    def characters_binaries
      @characters_binaries ||= binaries[(char_count * 4)..]
    end

    def font
      @font ||= Font.new(width:, height:)
    end
  end
end
