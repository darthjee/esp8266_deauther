# frozen_string_literal: true

class FontHelper
  class CharacterWritter
    attr_reader :character, :file

    delegate :empty?, :code, :size, :width, to: :character

    def self.write(*)
      new(*).write
    end

    def initialize(character, position, file)
      @character = character
      @position = position
      @file = file
    end

    def write
      file.write("  #{definition},  // #{code}:#{position} '#{character.character}'\n")
    end

    private

    def position
      return 65_535 if empty?

      @position
    end

    def definition
      definition_binary.map do |value|
        format('0x%02X', value)
      end.join(', ')
    end

    def definition_binary
      [
        start_byte_1,
        start_byte_2,
        size,
        width
      ]
    end

    def start_byte_1
      position / 256
    end

    def start_byte_2
      position % 256
    end
  end
end
