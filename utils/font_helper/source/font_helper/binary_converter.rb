# frozen_string_literal: true

class FontHelper
  module BinaryConverter
    def self.convert_bytes(bytes)
      bytes.map do |byte|
        BinaryConverter.to_bits(byte)
      end.flatten
    end

    def self.to_bits(byte)
      8.times.map do |exp|
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
