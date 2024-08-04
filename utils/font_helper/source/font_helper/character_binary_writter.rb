# frozen_string_literal: true

class FontHelper
  class CharacterBinaryWritter
    attr_reader :character, :file

    delegate :binary, :empty?, :code, to: :character

    def self.write(character, file)
      new(character, file).write
    end

    def initialize(character, file)
      @character = character
      @file = file
    end

    def write
      return if empty?

      file.write("  #{binaries}, // #{code}\n")
    end

    private

    def binaries
      binary.map do |value|
        format('0x%02X', value)
      end.join(', ')
    end
  end
end
