# frozen_string_literal: true

class FontHelper
  class CharacterWritter
    attr_reader :character, :file

    delegate :empty?, :code, to: :character

    def self.write(character, file)
      new(character, file).write
    end

    def initialize(character, file)
      @character = character
      @file = file
    end

    def write
      file.write("  #{definition}\n")
    end

    private

    def definition
      return "0xFF, 0xFF, 0x00, 0x07, // #{code}:65535" if empty?
      "0xFF, 0xFF, 0x00, 0x07, // #{code}:65535"
    end
  end
end
