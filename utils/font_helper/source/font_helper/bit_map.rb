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
  end
end
