# frozen_string_literal: true

class FontHelper
  class ImageReader
    attr_reader :code, :path

    def self.read(code, path)
      new(code, path).read
    end

    def initialize(code, path)
      @code = code
      @path = path
    end

    def read
      Character.new(code:, width:, height:, bitmap:)
    end

    private

    def bitmap
      bits.each_slice(height).to_a
    end

    def bits
      untrimed_bitmap.join.gsub(/0*$/, '').chars.map(&:to_i)
    end

    def untrimed_bitmap
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
