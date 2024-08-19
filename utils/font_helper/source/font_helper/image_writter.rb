# frozen_string_literal: true

class FontHelper
  class ImageWritter
    attr_reader :character, :path

    delegate :width, :height, :bit_at, to: :character

    def self.write(character, path)
      new(character, path).write
    end

    def initialize(character, path)
      @character = character
      @path = path
    end

    def write
      write_headers
      write_bits

      file.close
    end

    private

    def write_headers
      file.write("P1\n")
      file.write("#{width} #{height}\n")
    end

    def write_bits
      height.times do |line|
        write_line(line)
      end
    end

    def write_line(line)
      bits = width.times.map do |column|
        bit_at(line:, column:)
      end
      string = bits.join(" ")

      file.write("#{string}\n")
    end

    def file
      @file ||= File.open(path, 'w')
    end
  end
end
