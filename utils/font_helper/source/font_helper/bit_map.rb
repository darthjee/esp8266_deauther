# frozen_string_literal: true

class FontHelper
  class BitMap
    autoload :BitOperations,    'font_helper/bit_map/bit_operations'
    autoload :BinaryOperations, 'font_helper/bit_map/binary_operations'
    autoload :Flipper,          'font_helper/bit_map/flipper'

    include Sinclair::Comparable
    include BitOperations
    include BinaryOperations
    include Flipper

    attr_reader :height

    delegate :empty?, :size, :map, to: :binary

    comparable_by :byte_height, :binary

    def initialize(height:, binary: nil, bitmap: nil)
      @height = height
      @binary = binary
      @bitmap = bitmap
    end

    def byte_height
      @byte_height ||= (height / 8.0).ceil
    end

    def trim
      @binary = binary.join(',').gsub(/(,0)*$/, '').split(',').map(&:to_i)
    end

    def bitmap
      @bitmap ||= generate_bitmap.tap do
        @binary = nil
      end
    end

    def bitmap=(bitmap)
      @binary = nil
      @bitmap = bitmap
    end

    def remove_top(bits = 1)
      crop(top: bits)
    end

    def remove_bottom(bits = 1)
      crop(bottom: bits)
    end
  end
end
