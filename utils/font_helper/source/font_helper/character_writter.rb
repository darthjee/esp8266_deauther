# frozen_string_literal: true

class FontHelper
  class CharacterWritter
    attr_reader :character, :position, :file

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
      file.write("  #{definition}\n")
    end

    private

    def definition
      return "0xFF, 0xFF, 0x00, 0x07,  // #{code}:65535" if empty?
      "#{definition_binary},  // #{code}:#{position}"
    end

    def definition_binary
      [
        start_byte_1,
        start_byte_2,
        size,
        width
      ].map do |value|
        format('0x%02X', value)
      end.join(", ")
    end

    def start_byte_1
      position / 256
    end

    def start_byte_2
      position % 256
    end
  end
end
