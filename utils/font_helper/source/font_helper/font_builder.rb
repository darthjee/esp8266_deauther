class FontHelper
  class FontBuilder
    attr_reader :width, :height, :first_char, :char_count, :binaries

    class << self
      def build(*args)
        new(*args).build
      end
    end

    def initialize(width, height, first_char, char_count, *binaries)
      @width = width
      @height = height
      @first_char = first_char
      @char_count = char_count
      @binaries = binaries
    end

    def build
      font
    end

    private

    def font
      @font ||= Font.new(width:, height:)
    end
  end
end
