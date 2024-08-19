# frozen_string_literal: true

class FontHelper
  class ImageReader
    attr_reader :path

    def self.write(path)
      new(path).read
    end

    def initialize(path)
      @path = path
    end

    def read
      bitmap
    end

    private

    def bitmap
      numbers[2..]
    end

    def width
      numbers[0]
    end

    def height
      numbers[1]
    end

    def numbers
      @numbers ||= file_content
        .gsub(/#.*/, '')
        .gsub(/P1/, "")
        .gsub(/\n/, " ")
        .strip
        .split(" ")
        .map(&:to_i)
    end

    def file_content
      File.read(path)
    end
  end
end
