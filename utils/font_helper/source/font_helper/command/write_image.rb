# frozen_string_literal: true

class FontHelper
  class Command
    class WriteImage < Command
      attr_reader :code, :path

      comparable_by :code, :path

      def initialize(script, code:, path:)
        @code = code
        @path = path
        super(script)
      end

      def run
        ImageWritter.write(character, path)
      end

      private

      def character
        font.character(code)
      end
    end
  end
end
