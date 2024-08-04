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
      file.write("#{width.to_s(16)} // Width: #{width}\n")
      file.close
    end

    private

    def file
      @file ||= File.open(path, "w")
    end
  end
end
