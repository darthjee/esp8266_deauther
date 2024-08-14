# frozen_string_literal: true

class FontHelper
  class Character
    include Sinclair::Comparable

    attr_reader :code, :width

    comparable_by :code, :width, :binary

    delegate :size, :empty?, to: :binary

    def initialize(code:, width:, binary: nil)
      @code = code
      @width = width
      @binary = binary
    end

    def character
      code.chr
    end

    def binary
      @binary ||= []
    end

    def bitmap
      @bitmap ||= generate_bitmap
    end

    def generate_bitmap
      binary.map do |byte|
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
end
