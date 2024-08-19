# frozen_string_literal: true

class FontHelper
  class Character
    include Sinclair::Comparable

    attr_reader :code, :width

    delegate :size, :empty?, to: :binary
    delegate :binary, :height, :crop, :bit_at,
             :remove_top, :remove_bottom, to: :bit_map

    comparable_by :code, :width, :height, :binary

    def initialize(code:, width:, height:, binary: nil)
      @code = code
      @width = width
      @bit_map = BitMap.new(binary:, height:)
    end

    def character
      return unless code > 31 && code < 127

      code.chr
    end

    private

    attr_reader :bit_map
  end
end
