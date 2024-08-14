# frozen_string_literal: true

class FontHelper
  class BitMap
    include Sinclair::Comparable

    attr_reader :binary

    delegate :empty?, :size, :map, to: :binary

    comparable_by :binary

    def initialize(binary = [])
      @binary = binary || []
    end
  end
end
