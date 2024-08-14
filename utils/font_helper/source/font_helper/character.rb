# frozen_string_literal: true

class FontHelper
  class Character
    include Sinclair::Comparable

    attr_reader :code, :width, :height

    comparable_by :code, :width, :height, :binary

    delegate :size, :empty?, to: :binary

    def initialize(code:, width:, height:, binary: nil)
      @code = code
      @width = width
      @height = height
      @binary = BitMap.new(binary)
    end

    def byte_height
      (height / 8.0).ceil
    end

    def character
      code.chr
    end

    def binary
      @binary ||= Bitmap.new
    end

    def bitmap
      @bitmap ||= generate_bitmap
    end

    def generate_bitmap
      binary.map do |byte|
        BinaryConverter.to_bits(byte)
      end
    end
  end
end
