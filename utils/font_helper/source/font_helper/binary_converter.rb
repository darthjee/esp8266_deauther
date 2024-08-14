# frozen_string_literal: true

class FontHelper
  module BinaryConverter
    def self.to_bits(byte)
        [
          byte & 1,
          (byte & 2) / 2,
          (byte & 4) / 4,
          (byte & 8) / 8,
          (byte & 16) /16,
          (byte & 32) / 32,
          (byte & 64) / 64,
          (byte & 128) / 128,
        ]
    end
  end
end
