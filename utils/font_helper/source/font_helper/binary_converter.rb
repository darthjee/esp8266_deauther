# frozen_string_literal: true

class FontHelper
  module BinaryConverter
    def self.to_bits(byte)
      8.times.map do |exp|
        power = 2**exp
        (byte & power) / power
      end
    end
  end
end
