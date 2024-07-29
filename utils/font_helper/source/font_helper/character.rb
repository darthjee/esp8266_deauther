# frozen_string_literal: true

class FontHelper
  class Character
    attr_reader :code

    def initialize(code)
      @code = code
    end

    def character
      code.chr
    end
  end
end
