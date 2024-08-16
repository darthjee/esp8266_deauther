# frozen_string_literal: true

class FontHelper
  class Font
    include Sinclair::Comparable

    attr_reader :width, :height

    comparable_by :width, :height

    delegate :<<, :empty?, :delete, to: :characters

    def initialize(width:, height:, characters: nil)
      @width = width
      @height = height
      @characters = characters.to_h do |character|
        [character.code, character]
      end
    end

    def <<(character)
      characters[character.code] = character
    end

    def size
      return 0 if empty?

      last_character - first_character + 1
    end

    def first_character
      characters.keys.min
    end

    def last_character
      characters.keys.max
    end

    def characters
      @characters ||= {}
    end

    def character(code)
      characters[code] || Character.new(width:, code:, height:)
    end

    def crop(top: 0, bottom: 0)
      characters.each_value do |character|
        character.crop(top:, bottom:)
      end
    end

    def each
      characters_codes.each do |code|
        char = character(code)
        yield(code, char)
      end
    end

    def each_value
      each do |_code, char|
        yield(char)
      end
    end

    private

    def characters_codes
      (first_character..last_character)
    end
  end
end
