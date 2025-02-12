# frozen_string_literal: true

class FontHelper
  module BinaryConverter
    BYTE_SIZE = 8

    def self.convert_bytes(bytes)
      bytes.map do |byte|
        to_bits(byte)
      end.flatten
    end

    def self.convert_to_bytes(bits)
      bits.each_slice(BYTE_SIZE).map do |slice|
        to_byte(slice)
      end
    end

    def self.to_bits(byte)
      BYTE_SIZE.times.map do |exp|
        power = 2**exp
        (byte & power) / power
      end
    end

    def self.to_byte(bits)
      bits.map.with_index do |bit, exp|
        bit * (2**exp)
      end.sum
    end
  end
end
