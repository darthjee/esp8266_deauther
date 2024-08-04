# frozen_string_literal: true

class FontHelper
  class CharacterBinaryWritter
    attr_reader :character, :last, :file

    delegate :binary, :empty?, :code, to: :character

    def self.write(**)
      new(**).write
    end

    def initialize(character:, last:, file:)
      @character = character
      @last = last
      @file = file
    end

    def write
      return if empty?

      file.write("  #{binaries}#{separator} // #{code}\n")
    end

    private

    def separator
      return if last

      ','
    end

    def binaries
      binary.map do |value|
        format('0x%02X', value)
      end.join(', ')
    end
  end
end
