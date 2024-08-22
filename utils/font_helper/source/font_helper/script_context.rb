# frozen_string_literal: true

class FontHelper
  class ScriptContext
    attr_accessor :font

    def initialize(font: nil)
      @font = font
    end
  end
end
