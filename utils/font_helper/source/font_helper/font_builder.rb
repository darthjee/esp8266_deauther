class FontHelper
  class FontParser
    attr_reader :strings

    class << self
      def build(*args)
        new(*args).build
      end
    end

    def initialize(width, height, binaries)
      @strings = strings
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
