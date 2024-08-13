# frozen_string_literal: true

class FontHelper
  class FontWritter
    attr_reader :font, :path

    delegate :width, :height, :first_character, :size,
             :characters, :last_character, to: :font

    ATTRIBUTES = %i[width height first_character size].freeze
    LABELS = {
      width: 'Width',
      height: 'Height',
      first_character: 'First Char',
      size: 'Numbers of Chars'
    }.freeze

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

      position = 0
      font.each_value do |character|
        CharacterWritter.write(character, position, file)
        position += character.size
      end
    end

    def write_characters
      file.write("\n  // Font Data:\n")

      font.each do |code, character|
        last = code == last_character
        CharacterBinaryWritter.write(character:, last:, file:)
      end
    end

    def write_attr(attribute)
      value = public_send(attribute)
      hex = format('0x%02X', value)
      label = LABELS[attribute]

      file.write("  #{hex}, // #{label}: #{value}\n")
    end

    def file
      @file ||= File.open(path, 'w')
    end
  end
end
