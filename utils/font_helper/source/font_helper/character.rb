# frozen_string_literal: true

class FontHelper
  class Character
    include Sinclair::Comparable

    attr_reader :code, :width, :height

    comparable_by :code, :width, :height, :binary

    delegate :size, :empty?, to: :binary
    delegate :binary, :remove_top, to: :bit_map

    def initialize(code:, width:, height:, binary: nil)
      @code = code
      @width = width
      @height = height
      @bit_map = BitMap.new(byte_height:, binary:, height:)
    end

    def character
      code.chr
    end

    def byte_height
      @byte_height ||= (height / 8.0).ceil
    end

    private

    attr_reader :bit_map
  end
end
