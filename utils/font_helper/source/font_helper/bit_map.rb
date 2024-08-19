# frozen_string_literal: true

class FontHelper
  class BitMap
    include Sinclair::Comparable

    attr_reader :height

    delegate :empty?, :size, :map, to: :binary

    comparable_by :byte_height, :binary

    def initialize(height:, binary: [])
      @height = height
      @binary = binary
    end

    def byte_height
      @byte_height ||= (height / 8.0).ceil
    end

    def binary
      @binary ||= generate_binary.tap do
        @bitmap = nil
      end
    end

    def bit_at(line:, column:)
      return 0 unless bitmap[column]

      bitmap[column][line] || 0
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

    def crop(top: 0, bottom: 0)
      bits = top + bottom
      return if bits.zero?

      @bitmap = bitmap.map do |column|
        column[top, height - bits]
      end

      @height = height - bits
      @byte_height = nil
    end

    private

    def generate_binary
      return [] unless @bitmap

      bitmap.map do |column|
        column.each_slice(8).map do |bits|
          BinaryConverter.to_byte(bits)
        end
      end.flatten
    end

    def generate_bitmap
      bytes_columns.map do |column|
        column.map do |byte|
          BinaryConverter.to_bits(byte)
        end.flatten
      end
    end

    def bytes_columns
      binary.each_slice(byte_height).to_a
    end
  end
end
