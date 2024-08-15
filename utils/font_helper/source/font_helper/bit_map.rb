# frozen_string_literal: true

class FontHelper
  class BitMap
    include Sinclair::Comparable

    attr_reader :binary, :byte_height

    delegate :empty?, :size, :map, to: :binary

    comparable_by :byte_height, :binary

    def initialize(byte_height:, binary: [])
      @byte_height = byte_height
      @binary = binary || []
    end

    def bitmap
      @bitmap ||= generate_bitmap
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
