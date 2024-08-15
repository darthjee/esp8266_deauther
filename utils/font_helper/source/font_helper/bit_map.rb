# frozen_string_literal: true

class FontHelper
  class BitMap
    include Sinclair::Comparable

    attr_reader :binary, :byte_height

    delegate :empty?, :size, :map, to: :binary

    comparable_by :byte_height, :binary

    def initialize(byte_height:, binary: [])
      @byte_height = byte_height
      @binary = binary
    end

    def binary
      @binary ||= generate_binary
    end

    def bitmap
      @bitmap ||= generate_bitmap
    end

    private

    def generate_binary
      return [] unless @bitmap
      # TODO: code here
      bitmap.map do |column|
        column.each_slice(8)#.map
      end
    end

    def generate_bitmap
      bytes_columns.map do |column|
        column.map do |byte|
          BinaryConverter.to_bits(byte)
        end.flatten
      end.tap do
        @binary = nil
      end
    end

    def bytes_columns
      binary.each_slice(byte_height).to_a
    end
  end
end
