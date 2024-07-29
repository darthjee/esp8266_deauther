# frozen_string_literal: true

class FontHelper
  class Font
    attr_reader :width, :height

    delegate :<<, to: :characters

    def initialize(width, height, characters = nil)
      @width = width
      @height = height
      @characters = characters.to_h do |character|
        [character.code, character]
      end
    end

    def <<(character)
      characters[character.code] = character
    end

    def characters
      @characters ||= {}
    end

    def quantity
      characters.size
    end
  end
end
