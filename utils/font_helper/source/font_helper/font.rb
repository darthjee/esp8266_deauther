# frozen_string_literal: true

class FontHelper
  class Font
    include Sinclair::Comparable

    attr_reader :width, :height

    comparable_by :width, :height

    delegate :<<, to: :characters

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
      characters[code]
    end
  end
end
