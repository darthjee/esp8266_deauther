# frozen_string_literal: true

class FontHelper
  class Character
    include Sinclair::Comparable

    attr_reader :code, :width, :height

    comparable_by :code, :width, :height, :binary

    delegate :size, :empty?, to: :binary

    def initialize(code:, width:, height:, binary: nil)
      @code = code
      @width = width
      @height = height
      @bit_map = BitMap.new(byte_height:, binary:)
    end

    def byte_height
      @byte_height ||= (height / 8.0).ceil
    end

    def character
      code.chr
    end

    delegate :binary, to: :bit_map

    private

    attr_reader :bit_map
  end
end
