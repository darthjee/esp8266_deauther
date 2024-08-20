# frozen_string_literal: true

class FontHelper
  class Command
    class ReadImage < Command
      attr_reader :code, :path

      comparable_by :code, :path

      def initialize(script, code:, path:)
        @code = code
        @path = path
        super(script)
      end

      def run
        font << character
      end

      private

      def character
        ImageReader.read(code, path)
      end
    end
  end
end
