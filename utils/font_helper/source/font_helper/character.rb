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
        BinaryConverter.to_bits(byte)
      end
    end
  end
end
