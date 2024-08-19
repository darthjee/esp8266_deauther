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
      trimmed_bitmap
    end

    private

    def trimmed_bitmap
      bits.each_slice(height).to_a
    end

    def bits
      bitmap.join.gsub(/0*$/, '').chars.map(&:to_i)
    end

    def bitmap
      numbers[2..].each_slice(width).to_a.transpose
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
                   .gsub('P1', '')
                   .gsub("\n", ' ')
                   .strip
                   .split
                   .map(&:to_i)
    end

    def file_content
      File.read(path)
    end
  end
end
