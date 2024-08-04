# frozen_string_literal: true

class FontHelper
  class Character
    include Sinclair::Comparable

    attr_reader :code, :width, :binary

    comparable_by :code, :width, :binary

    delegate :size, to: :binary

    def initialize(code:, width:, binary:)
      @code = code
      @width = width
      @binary = binary
    end

    def empty?
      binary.nil?
    end

    def character
      code.chr
    end
  end
end
