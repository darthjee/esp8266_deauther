# frozen_string_literal: true

class FontHelper
  class FontWritter
    attr_reader :font, :path

    delegate :width, :height, :first_character, :quantity,
      :characters, to: :font

    ATTRIBUTES = %i[width height first_character quantity]
    LABELS = {
      width: "Width",
      height: "Height",
      first_character: "First Char",
      quantity: "Numbers of Chars"
    }

    def self.write(font, path)
      new(font, path).write
    end

    def initialize(font, path)
      @font = font
      @path = path
    end

    def write
      ATTRIBUTES.each { |attr| write_attr(attr) }

      write_jump_table
      write_characters

      file.close
    end

    private

    def write_jump_table
      file.write("\n  // Jump Table:\n")
      file.write("  // start point (1), start point (2), data size, block width\n")
    end

    def write_characters
      file.write("\n  // Font Data:\n")
      
      characters.keys.sort.each do |code|
        character = font.character(code)
        CharacterBinaryWritter.write(character, file)
      end
    end

    def write_attr(attribute)
      value = public_send(attribute)
      hex = ("%02x" % value).upcase
      label = LABELS[attribute]

      file.write("  0x#{hex}, // #{label}: #{value}\n")
    end

    def file
      @file ||= File.open(path, "w")
    end
  end
end
