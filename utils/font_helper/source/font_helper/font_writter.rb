# frozen_string_literal: true

class FontHelper
  class FontWritter
    attr_reader :font, :path

    delegate :width, :height, to: :font

    def self.write(font, path)
      new(font, path).write
    end

    def initialize(font, path)
      @font = font
      @path = path
    end

    def write
      write_attr(:width)
      file.close
    end

    private

    def write_attr(attribute)
      value = public_send(attribute)
      hex = value.to_s(16)
      file.write("  0x#{hex}, // Width: #{value}\n")
    end

    def file
      @file ||= File.open(path, "w")
    end
  end
end
