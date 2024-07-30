# frozen_string_literal: true

class FontHelper
  class Character
    include Sinclair::Comparable

    attr_reader :code

    comparable_by :code

    def initialize(code:)
      @code = code
    end

    def character
      code.chr
    end
  end
end
