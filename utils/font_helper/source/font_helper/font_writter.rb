# frozen_string_literal: true

class FontHelper
  class FontWritter
    attr_reader :font, :path

    delegate :width, :height, :first_character, to: :font

    ATTRIBUTES = %i[width height first_character]
    LABELS = {
      width: "Width",
      height: "Height",
      first_character: "First Char"
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

      file.close
    end

    private

    def write_attr(attribute)
      value = public_send(attribute)
      hex = value.to_s(16).upcase
      label = LABELS[attribute]

      file.write("  0x#{hex}, // #{label}: #{value}\n")
    end

    def file
      @file ||= File.open(path, "w")
    end
  end
end
